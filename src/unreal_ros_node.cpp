/*
 * 2017, Yilong Li.
 *
 * Copyright (c) 2008, Willow Garage, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the Willow Garage, Inc. nor the names of its
 *       contributors may be used to endorse or promote products derived from
 *       this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <fstream>
#include <iostream>
#include <chrono>
#include <math.h>
#include <unistd.h>
#include <set>

#include <map>

#include <angles/angles.h>
#include <urdf/model.h>

#include "sensor_msgs/JointState.h"
#include "pr2_unreal/unreal_ros_node.h"

UnrealRosNode::~UnrealRosNode()
{
    ROS_DEBUG("Calling FiniChild in GazeboRosControllerManager");

    this->cm_->~ControllerManager();
    this->rosnode_->shutdown();
    this->ros_spinner_thread_.join();

    delete this->cm_;
    delete this->rosnode_;

    if (this->fake_state_)
      delete this->fake_state_;
}

void UnrealRosNode::Load()
{

    if (getenv("CHECK_SPEEDUP"))
    {
      wall_start_ = std::chrono::duration_cast<std::chrono::microseconds>
              (std::chrono::system_clock::now().time_since_epoch()).count() / 1000000.0; // get wall clock
      sim_start_  = ros::Time::now().toSec(); // get sim clock
    }

    this->robotNamespace = "";
    this->robotParam = "robot_description";
    this->robotParam = this->robotNamespace+"/" + this->robotParam;

    if (!ros::isInitialized())
    {
      int argc = 0;
      char** argv = NULL;
      ros::init(argc,argv,"unreal",ros::init_options::NoSigintHandler);
    }
    this->rosnode_ = new ros::NodeHandle(this->robotNamespace);
    ROS_INFO("starting unreal_ros_node in ns: %s",this->robotNamespace.c_str());

    // load a controller manager
    this->cm_ = new pr2_controller_manager::ControllerManager(&hw_,*this->rosnode_);
    this->hw_.current_time_ = ros::Time::now();
    if (this->hw_.current_time_ < ros::Time(0.001))
        this->hw_.current_time_ == ros::Time(0.001); // hardcoded to minimum of 1ms on start up

    this->rosnode_->param("gazebo/start_robot_calibrated",this->fake_calibration_,true); // ?

    // read pr2 urdf
    // setup actuators, then setup mechanism control node
    ReadPr2Xml();

    // Initializes the fake state (for running the transmissions backwards).
    this->fake_state_ = new pr2_mechanism_model::RobotState(&this->cm_->model_);

    // The gazebo joints and mechanism joints should match up.
    if (this->cm_->state_ != NULL) // could be NULL if ReadPr2Xml is unsuccessful
        for (unsigned int i = 0; i < this->cm_->state_->joint_states_.size(); ++i)
        {
            std::string joint_name = this->cm_->state_->joint_states_[i].joint_->name;
            this->joint_name.push_back(joint_name);
            ROS_INFO("JOINT NAME: %s TYPE: %d",joint_name.c_str(), this->cm_->state_->joint_states_[i].joint_->type);

            /** TODO: we need to check if this joint is in Unreal game */
        }

    joint_state_sub = this->rosnode_->subscribe("unreal_joint_state", 1, &UnrealRosNode::JointStateCallback, this);
    force_pub = this->rosnode_->advertise<sensor_msgs::JointState>("unreal_force", 1);
}

void UnrealRosNode::JointStateCallback(const sensor_msgs::JointState::ConstPtr& msg)
{
    ROS_INFO("Joint State Callback");
    for (auto it = this->joint_velocity.begin(); it != this->joint_velocity.end(); it++)
        it->second = 0;
    for (auto it = this->joint_position.begin(); it != this->joint_position.end(); it++)
        it->second = 0;

    for (int i = 0; i < msg->name.size(); i++)
    {
        std::string name = msg->name[i];
        this->joint_position[name] = msg->position[i];
        this->joint_velocity[name] = msg->velocity[i];
    }

    Update();
}

/** This function should be called after the `callback` function, which updates
 *  "joint_position" and "joint_velocity" maps. It publishes "joint_effort". */
void UnrealRosNode::Update()
{
    //--------------------------------------------------
    //  Pushes out simulation state
    //--------------------------------------------------
    assert(this->joint_name.size() == this->fake_state_->joint_states_.size());

    for (unsigned int i = 0; i < this->joint_name.size(); i++)
    {
        std::string curr_joint_name = joint_name[i];
        this->fake_state_->joint_states_[i].measured_effort_ = this->fake_state_->joint_states_[i].commanded_effort_;
        if (this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::REVOLUTE ||
            this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::CONTINUOUS)
        {
            this->fake_state_->joint_states_[i].position_ = this->fake_state_->joint_states_[i].position_ +
                          angles::shortest_angular_distance(this->fake_state_->joint_states_[i].position_,
                                                            angles::from_degrees(this->joint_position[curr_joint_name]));
            this->fake_state_->joint_states_[i].velocity_ = angles::from_degrees(this->joint_velocity[curr_joint_name]);
        }
        else if (this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::PRISMATIC)
        {
            this->fake_state_->joint_states_[i].position_ = this->joint_position[curr_joint_name] / 100.0; // cm   -> m
            this->fake_state_->joint_states_[i].velocity_ = this->joint_velocity[curr_joint_name] / 100.0; // cm/s -> m/s
        }
    }

    // Reverses the transmissions to propagate the joint position into the actuators.
    this->fake_state_->propagateJointPositionToActuatorPosition();


    //--------------------------------------------------
    //  Runs Mechanism Control
    //--------------------------------------------------
    this->hw_.current_time_ = ros::Time::now(); // use simulation time from /clock
    try
    {
        if (this->cm_->state_ != NULL) // could be NULL if ReadPr2Xml is unsuccessful
            this->cm_->update();
    }
    catch (const char* c)
    {
        if (strcmp(c,"dividebyzero")==0)
            ROS_WARN("pid controller reports divide by zero error");
        else
            ROS_WARN("unknown const char* exception: %s", c);
    }

    //--------------------------------------------------
    //  Takes in actuation commands
    //--------------------------------------------------

    // Reverses the transmissions to propagate the actuator commands into the joints.
    this->fake_state_->propagateActuatorEffortToJointEffort();

    // Copies the commands from the mechanism joints into the gazebo joints.
    for (unsigned int i = 0; i < this->joint_name.size(); ++i)
    {
        std::string curr_joint_name = joint_name[i];
        double effort = this->fake_state_->joint_states_[i].commanded_effort_;

        double damping_coef = 0;
        if (this->cm_->state_ != NULL) // could be NULL if ReadPr2Xml is unsuccessful
        {
            if (this->cm_->state_->joint_states_[i].joint_->dynamics)
                damping_coef = this->cm_->state_->joint_states_[i].joint_->dynamics->damping;
        }

        if (this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::REVOLUTE ||
            this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::CONTINUOUS)
        {
            double current_velocity = this->joint_velocity[curr_joint_name];
            double damping_force = damping_coef * current_velocity;
            double effort_command = effort - damping_force;
            this->joint_effort[curr_joint_name] = effort_command;
            //if (this->joints_[i]->GetName() == "torso_lift_motor_screw_joint")
            //  ROS_ERROR("gazebo [%s] command [%f] damping [%f]",this->joints_[i]->GetName().c_str(), effort, damping_force);
        }
        else if (this->fake_state_->joint_states_[i].joint_->type == urdf::Joint::PRISMATIC)
        {
            double current_velocity = this->joint_velocity[curr_joint_name];
            double damping_force = damping_coef * current_velocity;
            double effort_command = effort-damping_force;
            this->joint_effort[curr_joint_name] = effort_command;
            //if (this->joints_[i]->GetName() == "torso_lift_joint")
            //  ROS_ERROR("gazebo [%s] command [%f] damping [%f]",this->joints_[i]->GetName().c_str(), effort, damping_force);
        }
    }

    sensor_msgs::JointState msg_joint_state;
    msg_joint_state.name = this->joint_name;
    msg_joint_state.effort.clear();
    for (int i = 0; i < msg_joint_state.name.size(); i++)
        msg_joint_state.effort.push_back(this->joint_effort[this->joint_name[i]]);
    msg_joint_state.header = std_msgs::Header();
    msg_joint_state.header.stamp = ros::Time::now();

    force_pub.publish(msg_joint_state);
}

void UnrealRosNode::ReadPr2Xml()
{

    std::string urdf_param_name;
    std::string urdf_string;
    // search and wait for robot_description on param server
    while(urdf_string.empty())
    {
        ROS_INFO("gazebo controller manager plugin is waiting for urdf: %s on the param server.  (make sure there is a rosparam by that name in the ros parameter server, otherwise, this plugin blocks simulation forever).", this->robotParam.c_str());
        if (this->rosnode_->searchParam(this->robotParam,urdf_param_name))
        {
            this->rosnode_->getParam(urdf_param_name,urdf_string);
            ROS_DEBUG("found upstream\n%s\n------\n%s\n------\n%s",this->robotParam.c_str(),urdf_param_name.c_str(),urdf_string.c_str());
        }
        else
        {
            this->rosnode_->getParam(this->robotParam,urdf_string);
            ROS_DEBUG("found in node namespace\n%s\n------\n%s\n------\n%s",this->robotParam.c_str(),urdf_param_name.c_str(),urdf_string.c_str());
        }
        usleep(100000);
    }
    ROS_INFO("gazebo controller manager got pr2.xml from param server, parsing it...");

    // initialize TiXmlDocument doc with a string
    TiXmlDocument doc;
    if (!doc.Parse(urdf_string.c_str()) && doc.Error())
    {
        ROS_ERROR("Could not load the gazebo controller manager plugin's configuration file: %s\n",
                  urdf_string.c_str());
    }
    else
    {
        //doc.Print();
        //std::cout << *(doc.RootElement()) << std::endl;

        // Pulls out the list of actuators used in the robot configuration.
        struct GetActuators : public TiXmlVisitor
        {
            std::set<std::string> actuators;
            virtual bool VisitEnter(const TiXmlElement &elt, const TiXmlAttribute *)
            {
                if (elt.ValueStr() == std::string("actuator") && elt.Attribute("name"))
                    actuators.insert(elt.Attribute("name"));
                else if (elt.ValueStr() == std::string("rightActuator") && elt.Attribute("name"))
                    actuators.insert(elt.Attribute("name"));
                else if (elt.ValueStr() == std::string("leftActuator") && elt.Attribute("name"))
                    actuators.insert(elt.Attribute("name"));
                return true;
            }
        } get_actuators;
        doc.RootElement()->Accept(&get_actuators);

        // Places the found actuators into the hardware interface.
        std::set<std::string>::iterator it;
        for (it = get_actuators.actuators.begin(); it != get_actuators.actuators.end(); ++it)
        {
            //std::cout << " adding actuator " << (*it) << std::endl;
            pr2_hardware_interface::Actuator* pr2_actuator = new pr2_hardware_interface::Actuator(*it);
            pr2_actuator->state_.is_enabled_ = true;
            this->hw_.addActuator(pr2_actuator);
        }

        // Setup mechanism control node
        this->cm_->initXml(doc.RootElement());

        for (unsigned int i = 0; i < this->cm_->state_->joint_states_.size(); ++i)
            this->cm_->state_->joint_states_[i].calibrated_ = fake_calibration_;
    }
}

int main(int argc, char** argv)
{
    UnrealRosNode unreal_ros_node;
    unreal_ros_node.Load();
    /* ros::Rate r(100);
    while (ros::ok())
    {
        ROS_INFO("tick");
        ros::spinOnce();
        r.sleep();
    }
    ROS_INFO("end"); */
    ros::MultiThreadedSpinner spinner(4); // use multi-thread spinner to avoid blocking
    spinner.spin();
    return 0;
}
