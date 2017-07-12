/*
 * Copyright (c) 2009, Willow Garage, Inc.
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

#include <ros/ros.h>

// Action Interface
#include <actionlib/server/action_server.h>
#include <pr2_tilt_laser_interface/GetSnapshotAction.h>

// Controller Interface
#include <pr2_msgs/SetLaserTrajCmd.h>

// Laser Processing
#include <sensor_msgs/LaserScan.h>
#include <laser_geometry/laser_geometry.h>
#include <pcl_ros/transforms.h>
#include <pcl_conversions/pcl_conversions.h>

#include <tf/transform_listener.h>
#include "tf/message_filter.h"
#include <message_filters/subscriber.h>
#include <pcl/io/io.h>

void appendCloud(sensor_msgs::PointCloud2& dest, const sensor_msgs::PointCloud2& src)
{
  // TODO: Add error/consistency checking here
  dest.height += 1;

  size_t start = dest.data.size ();

  if (start == 0)
  {
    dest = src;
    return;
  }

  dest.data.resize (start + src.data.size ());
  memcpy (&dest.data[start], &src.data[0], src.data.size ());

  // Get the time index field offset
  int time_index = src.fields[pcl::getFieldIndex (dest, "timestamp")].offset;
  float time_offset = src.header.stamp.toSec () - dest.header.stamp.toSec ();
  float* time_ptr;
  for (size_t i = 0; i < src.width * src.height; ++i)
  {
    time_ptr = (float*) &dest.data[start + i * src.point_step + time_index];
    *time_ptr += time_offset;
  }
}

using namespace pr2_tilt_laser_interface;

namespace SnapshotStates
{
  enum SnapshotState
  {
    COLLECTING = 1,
    IDLE = 2
  };
}
typedef SnapshotStates::SnapshotState SnapshotState;

typedef actionlib::ActionServer<GetSnapshotAction> SnapshotActionServer;

class Snapshotter
{
public:
  Snapshotter();

  void startScan(double move_to_start_wait_time=1.0);
  
  void scanCallback(const sensor_msgs::LaserScanConstPtr& scan);

  // Action Interface
  void goalCallback(SnapshotActionServer::GoalHandle gh);
  void cancelCallback(SnapshotActionServer::GoalHandle gh);

private:
  ros::NodeHandle nh_;
  SnapshotActionServer as_;

  message_filters::Subscriber<sensor_msgs::LaserScan> scan_sub_;
  ros::ServiceClient laser_controller_sc_;

  boost::mutex state_mutex_;
  SnapshotState state_;
  ros::Time interval_start_;
  ros::Time interval_end_;
  laser_geometry::LaserProjection lg_;
  GetSnapshotResult snapshot_result_;
  GetSnapshotFeedback snapshot_feedback_;

  SnapshotActionServer::GoalHandle current_gh_;
  GetSnapshotGoal goal_;

  tf::TransformListener tf_;
  std::string fixed_frame_;
  boost::scoped_ptr<tf::MessageFilter<sensor_msgs::LaserScan> > tf_filter_;
  
};

Snapshotter::Snapshotter() :
  as_(nh_, "get_laser_snapshot", false),
  state_(SnapshotStates::IDLE),
  tf_(nh_)
{
  as_.registerGoalCallback(    boost::bind(&Snapshotter::goalCallback,    this, _1) );
  as_.registerCancelCallback(  boost::bind(&Snapshotter::cancelCallback, this, _1) );

  // Initialize interface to the controller
  // TODO: Make this into an action interface, once the controller supports it
  laser_controller_sc_ = nh_.serviceClient<pr2_msgs::SetLaserTrajCmd>("laser_tilt_controller/set_traj_cmd");

  // Grab the fixed frame off the parameter server
  ros::NodeHandle private_ns_("~");
  if (!private_ns_.getParam("fixed_frame", fixed_frame_))
      ROS_FATAL("Need to set parameter ~fixed_frame");
  ROS_DEBUG("Using fixed frame [%s]", fixed_frame_.c_str());

  // Set up the tf filter
  scan_sub_.subscribe(nh_, "tilt_scan", 10);
  tf_filter_.reset( new tf::MessageFilter<sensor_msgs::LaserScan>(scan_sub_, tf_, fixed_frame_, 10) );
  tf_filter_->setTolerance(ros::Duration(0.025));
  tf_filter_->registerCallback( boost::bind(&Snapshotter::scanCallback, this, _1) );

  // Start the action server
  as_.start();
}

void Snapshotter::scanCallback(const sensor_msgs::LaserScanConstPtr& scan)
{
  boost::mutex::scoped_lock lock(state_mutex_);

  if (state_ == SnapshotStates::IDLE)
    return;

  sensor_msgs::PointCloud2& cloud = (goal_.continuous ? snapshot_feedback_.cloud : snapshot_result_.cloud);
  
  if (state_ == SnapshotStates::COLLECTING)
  {
    if (scan->header.stamp < interval_start_)
    {
      ROS_DEBUG("Waiting to get to the start of the interval");
      // Can't do anything since we haven't gotten to our interval yet
      return;
    }
    else if (scan->header.stamp < interval_end_)
    {
      // Process Scans
      ROS_DEBUG("In the actual interval");
      sensor_msgs::PointCloud2 cur_cloud_tf;

      if (!goal_.hi_fidelity)
      {
        sensor_msgs::PointCloud2 cur_cloud;
        lg_.projectLaser (*scan, cur_cloud);
        tf::StampedTransform net_transform;
        tf_.lookupTransform (fixed_frame_, cur_cloud.header.frame_id, cur_cloud.header.stamp, net_transform);
        pcl_ros::transformPointCloud (fixed_frame_, net_transform, cur_cloud, cur_cloud_tf);
      }
      else
      {
        lg_.transformLaserScanToPointCloud (fixed_frame_, *scan, cur_cloud_tf, tf_);
      }
      appendCloud (cloud, cur_cloud_tf);
    }
    else
    {
      ROS_DEBUG ("Bundling everything up and publishing cloud with %u points", cloud.width * cloud.width);

      state_ = SnapshotStates::IDLE;
      
      if (goal_.continuous)
      {
        // TODO: Send out msg and start next scan
        current_gh_.publishFeedback (snapshot_feedback_);
        std::swap(goal_.start_angle, goal_.end_angle);
        startScan(0.1);
      }
      else
      {
        current_gh_.setSucceeded (snapshot_result_);
      }
      cloud.data.clear ();
    }
  }
  else
    ROS_ERROR("In an unknown state.  This is a programming error");

}

void Snapshotter::goalCallback(SnapshotActionServer::GoalHandle gh)
{
  boost::mutex::scoped_lock lock(state_mutex_);
  
  // Preemption Logic
  if (state_ != SnapshotStates::IDLE)
  {
    current_gh_.setCanceled();
    state_ = SnapshotStates::IDLE;
  }

  current_gh_ = gh;
  current_gh_.setAccepted();
  
  goal_ = *current_gh_.getGoal();

  startScan();
}

void Snapshotter::startScan(double move_to_start_wait_time)
{
  //boost::mutex::scoped_lock lock(state_mutex_);

  // Build the service request for the tilt laser controller

  pr2_msgs::LaserTrajCmd cmd;

  cmd.profile = "linear";
  cmd.position.resize(4);
  cmd.position[0] = goal_.start_angle;
  cmd.position[1] = goal_.start_angle;
  cmd.position[2] = goal_.end_angle;
  cmd.position[3] = (goal_.continuous ? goal_.end_angle : goal_.start_angle);

  if (goal_.speed==0.0)
  {
    ROS_ERROR("Scan speed is set to zero -> aborting!\n");
    return;
  }
  
  ros::Duration scan_duration( (goal_.start_angle - goal_.end_angle)/goal_.speed );
  if (scan_duration.toSec() < 0.0)
    scan_duration = -scan_duration;

  ros::Duration wait_time(move_to_start_wait_time);
  cmd.time_from_start.resize(4);
  cmd.time_from_start[0] = ros::Duration(0.0);
  cmd.time_from_start[1] = wait_time;
  cmd.time_from_start[2] = wait_time + scan_duration;
  cmd.time_from_start[3] = wait_time + scan_duration + scan_duration;
  cmd.max_velocity = 0;
  cmd.max_acceleration= 0;

  pr2_msgs::SetLaserTrajCmd laser_srv_cmd;
  laser_srv_cmd.request.command = cmd;

  laser_controller_sc_.call(laser_srv_cmd);

  // Determine the interval that we care about, based on the service response
  interval_start_ = laser_srv_cmd.response.start_time + cmd.time_from_start[1];
  interval_end_   = laser_srv_cmd.response.start_time + cmd.time_from_start[2];

  // Load the new goal
  assert(state_ == SnapshotStates::IDLE);
  state_ = SnapshotStates::COLLECTING;
  
  snapshot_feedback_.cloud.data.clear();
  snapshot_result_.cloud.data.clear();
}

void Snapshotter::cancelCallback(SnapshotActionServer::GoalHandle gh)
{
  boost::mutex::scoped_lock lock(state_mutex_);

  // See if our current goal is the one that needs to be cancelled
  if (current_gh_ != gh)
  {
    ROS_DEBUG("Got a cancel request for some other goal. Ignoring it");
    return;
  }
  current_gh_.setCanceled();
  state_ = SnapshotStates::IDLE;
}

//void printUsage(const char* progName)
//{
  //std::cout << "\n\nUsage: "<<progName<<" [options]\n\n"
            //<< "Options:\n"
            //<< "-------------------------------------------\n"
            //<< "-c           Continuous - after receiving one action request, continue doing 3D scans all the time.\n"
            //<< "-h           this help\n"
            //<< "\n\n";
//}

int main(int argc, char** argv)
{
  //// Read command line arguments.
  //bool continuous_mode = false;
  //for (char c; (c = getopt(argc, argv, "ch")) != -1; ) {
    //switch (c) {
      //case 'c':
        //continuous_mode = true;
        //std::cout << "Using continuous mode.\n";
        //break;
      //case 'h':
        //printUsage(argv[0]);
        //exit(0);
    //}
  //}
  
  ros::init(argc, argv, "laser_snapshotter");
  Snapshotter snapshotter;
  ros::spin();
}
