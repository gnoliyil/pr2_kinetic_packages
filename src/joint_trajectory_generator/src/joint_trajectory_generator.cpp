/*********************************************************************
 *
 * Software License Agreement (BSD License)
 *
 *  Copyright (c) 2009, Willow Garage, Inc.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above
 *     copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided
 *     with the distribution.
 *   * Neither the name of Willow Garage, Inc. nor the names of its
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 *  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 *  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 *  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *  POSSIBILITY OF SUCH DAMAGE.
 *
 * Author: Eitan Marder-Eppstein
 *********************************************************************/
#include <ros/ros.h>
#include <actionlib/server/simple_action_server.h>
#include <actionlib/client/simple_action_client.h>

#include <pr2_controllers_msgs/JointTrajectoryAction.h>
#include <pr2_controllers_msgs/JointTrajectoryControllerState.h>

#include <angles/angles.h>
#include <urdf/model.h>
#include <urdf_model/joint.h>

#include <joint_trajectory_generator/trajectory_generation.h>

namespace joint_trajectory_generator {
  class JointTrajectoryGenerator
  {
    private:
      typedef actionlib::SimpleActionServer<pr2_controllers_msgs::JointTrajectoryAction> JTAS;
      typedef actionlib::SimpleActionClient<pr2_controllers_msgs::JointTrajectoryAction> JTAC;
    public:
    JointTrajectoryGenerator(std::string name) : 
      as_(ros::NodeHandle(), "joint_trajectory_generator",
          boost::bind(&JointTrajectoryGenerator::executeCb, this, _1),
          false),
      ac_("joint_trajectory_action"),
      got_state_(false)
      {
        ros::NodeHandle n;
        state_sub_ = n.subscribe("state", 1, &JointTrajectoryGenerator::jointStateCb, this);

        ros::NodeHandle pn("~");
        pn.param("max_acc", max_acc_, 0.5);
        pn.param("max_vel", max_vel_, 5.0);

        // Load Robot Model
        ROS_DEBUG("Loading robot model");
        std::string xml_string;
        ros::NodeHandle nh_toplevel;
        if (!nh_toplevel.getParam(std::string("/robot_description"), xml_string))
          throw ros::Exception("Could not find paramter robot_description on parameter server");

        if(!robot_model_.initString(xml_string)) 
          throw ros::Exception("Could not parse robot model");

        ros::Rate r(10.0);
        while(!got_state_){
          ros::spinOnce();
          r.sleep();
        }

        ac_.waitForServer();
        as_.start();
        ROS_INFO("%s: Initialized",name.c_str());
      }

      void jointStateCb(const pr2_controllers_msgs::JointTrajectoryControllerStateConstPtr& state){
        boost::mutex::scoped_lock lock(mutex_);
        for(unsigned int i = 0; i < state->joint_names.size(); ++i){
          current_state_[state->joint_names[i]] = state->actual.positions[i];
        }
        got_state_ = true;
      }

      pr2_controllers_msgs::JointTrajectoryGoal createGoal(const pr2_controllers_msgs::JointTrajectoryGoal& goal){
        pr2_controllers_msgs::JointTrajectoryGoal new_goal;
        new_goal.trajectory.header = goal.trajectory.header;
        new_goal.trajectory.joint_names = goal.trajectory.joint_names;

        size_t n_traj_points = goal.trajectory.points.size(),
               n_joint_names = goal.trajectory.joint_names.size();

        // Increase traj length to account for the initial pose
        ROS_DEBUG_STREAM("Initial trajectory has "<<n_traj_points<<" points.");
        new_goal.trajectory.points.resize(n_traj_points + 1);
  
        // Set joint names
        for(size_t i=0; i<n_traj_points+1; i++) {
          new_goal.trajectory.points[i].positions.resize(n_joint_names);
        }

        {
          boost::mutex::scoped_lock lock(mutex_);
          //add the current point as the start of the trajectory
          for(unsigned int i = 0; i < n_joint_names; ++i){
            // Generate the first point
            if(current_state_.find(new_goal.trajectory.joint_names[i]) == current_state_.end()) {
              ROS_FATAL_STREAM("Joint names in goal and controller don't match. Something is very wrong. Goal joint name: "<<new_goal.trajectory.joint_names[i]);
              throw std::runtime_error("Joint names in goal and controller don't match. Something is very wrong.");
            }
            new_goal.trajectory.points[0].positions[i] = current_state_[new_goal.trajectory.joint_names[i]];

            // Get the joint and calculate the offset from the current state
            boost::shared_ptr<const urdf::Joint> joint = robot_model_.getJoint(new_goal.trajectory.joint_names[i]);
            double offset = 0;

            double goal_position = goal.trajectory.points[0].positions[i],
                   current_position = new_goal.trajectory.points[0].positions[i];

            if(joint->type == urdf::Joint::REVOLUTE) {
              offset = 0;
            } else if(joint->type == urdf::Joint::CONTINUOUS) {
              offset = current_position - goal_position - angles::shortest_angular_distance(goal_position, current_position);
            } else {
              ROS_WARN("Unknown joint type in joint trajectory. This joint might not be unwrapped properly. Supported joint types are urdf::Joint::REVOLUTE and urdf::Joint::CONTINUOUS");
              offset = 0;
            }

            // Apply offset to each point in the trajectory on this joint
            for(unsigned int j=0; j < n_traj_points; j++) {
	      new_goal.trajectory.points[j+1].time_from_start = goal.trajectory.points[j].time_from_start;
              new_goal.trajectory.points[j+1].positions[i] = goal.trajectory.points[j].positions[i] + offset;
            }
          }
        }

        //todo pass into trajectory generator here
        trajectory::TrajectoryGenerator g(max_vel_, max_acc_, new_goal.trajectory.joint_names.size());

        //do the trajectory generation
        g.generate(new_goal.trajectory, new_goal.trajectory);

        return new_goal;
      }

      void executeCb(const pr2_controllers_msgs::JointTrajectoryGoalConstPtr& goal){
        ROS_DEBUG("Got a goal");

        pr2_controllers_msgs::JointTrajectoryGoal full_goal;
        try {
          full_goal = createGoal(*goal);
        } catch (ros::Exception ex) {
          ROS_ERROR_STREAM(ex.what());
          as_.setAborted();
          return;
        }

        ac_.sendGoal(full_goal, JTAC::SimpleDoneCallback(), JTAC::SimpleActiveCallback(), boost::bind(&JointTrajectoryGenerator::feedbackCb, this, _1));

        while(ros::ok() && !ac_.waitForResult(ros::Duration(0.05))){
          if(as_.isPreemptRequested()){
            if(as_.isNewGoalAvailable()){
              ROS_DEBUG("Preempted by new goal");
              boost::shared_ptr<const pr2_controllers_msgs::JointTrajectoryGoal> new_goal = as_.acceptNewGoal();
              full_goal = createGoal(*new_goal);
              ac_.sendGoal(full_goal, JTAC::SimpleDoneCallback(),
                  JTAC::SimpleActiveCallback(),
                  boost::bind(&JointTrajectoryGenerator::feedbackCb, this, _1));
            }
            else{
              ROS_DEBUG("Preempted by cancel");
              ac_.cancelGoal();
            }
          }
        }

        if(!ros::ok()){
          as_.setAborted();
          return;
        }

        actionlib::SimpleClientGoalState state = ac_.getState();
        pr2_controllers_msgs::JointTrajectoryResultConstPtr result = ac_.getResult();

        if(state == actionlib::SimpleClientGoalState::PREEMPTED){
          ROS_DEBUG("Preempted");
          as_.setPreempted(*result);
        }
        else if(state == actionlib::SimpleClientGoalState::SUCCEEDED){
          ROS_DEBUG("Succeeded ");
          as_.setSucceeded(*result);
        }
        else if(state == actionlib::SimpleClientGoalState::ABORTED){
          ROS_DEBUG("Aborted ");
          as_.setAborted(*result);
        }
        else
          as_.setAborted(*result, "Unknown result from joint_trajectory_action");

      }

      void feedbackCb(const pr2_controllers_msgs::JointTrajectoryFeedbackConstPtr& feedback){
        as_.publishFeedback(feedback);
      }

    private:
      JTAS as_;
      JTAC ac_;
      boost::mutex mutex_;
      std::map<std::string, double> current_state_;
      ros::Subscriber state_sub_;
      bool got_state_;
      double max_acc_, max_vel_;
      urdf::Model robot_model_;

  };
};

int main(int argc, char** argv){
  ros::init(argc, argv, "joint_trajectory_generator_node");
  joint_trajectory_generator::JointTrajectoryGenerator jtg(ros::this_node::getName());

  ros::spin();

  return 0;
}
