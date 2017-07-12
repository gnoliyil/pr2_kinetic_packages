
/*********************************************************************       
 * Software License Agreement (BSD License)                                  
 *                                                                           
 *  Copyright (c) 2008, Willow Garage, Inc.                                  
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
 *   * Neither the name of Willow Garage nor the names of its                
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
 * Author: Wim Meeussen
 *********************************************************************/

#include <ros/ros.h>
#include <joint_trajectory_generator/trajectory_generation.h>
#include <kdl/velocityprofile_trap.hpp>


namespace trajectory{

  TrajectoryGenerator::TrajectoryGenerator(double max_vel, double max_acc, unsigned int size)
    : generators_(size)
  {
    for (unsigned int i=0; i<size; i++)
      generators_[i] = new KDL::VelocityProfile_Trap(max_vel, max_acc);
  }


  TrajectoryGenerator::~TrajectoryGenerator()
  {
    for (unsigned int i=0; i<generators_.size(); i++)
      delete generators_[i];
  }

  void TrajectoryGenerator::generate(const trajectory_msgs::JointTrajectory& traj_in, trajectory_msgs::JointTrajectory& traj_out)
  {
    ROS_DEBUG("Generating trajectory for list of points of size %d", (int) traj_in.points.size());

    // check trajectory message
    if (traj_in.points.size() < 2){
      ROS_WARN("Trajectory message should contain at least two points, but it contains %d points. Returning original trajectory", (int)traj_in.points.size());
      traj_out = traj_in;
      throw ros::Exception("Trajectory contains fewer than two points.");
    }

    // default result
    trajectory_msgs::JointTrajectory traj_res = traj_in;
    traj_res.points.clear();
    trajectory_msgs::JointTrajectoryPoint points_tmp; 
    points_tmp.positions.resize(generators_.size());
    points_tmp.velocities.resize(generators_.size());
    points_tmp.accelerations.resize(generators_.size());

    double initial_time = traj_in.points[0].time_from_start.toSec();

    for (unsigned int pnt=0; pnt<traj_in.points.size()-1; pnt++){
      // check
      if (traj_in.points[pnt].positions.size() != generators_.size() ||
          traj_in.points[pnt+1].positions.size() != generators_.size()){
        ROS_ERROR("The point lists in the trajectory do not have the same size as the generators");
        return;
      }

      // generate initial profiles
      for (unsigned int i=0; i<generators_.size(); i++)
        generators_[i]->SetProfile(traj_in.points[pnt].positions[i], traj_in.points[pnt+1].positions[i]);

      // find profile that takes most time
      double max_time = (traj_in.points[pnt+1].time_from_start - traj_in.points[pnt].time_from_start).toSec();
      for (unsigned int i=0; i<generators_.size(); i++)
        if (generators_[i]->Duration() > max_time)
          max_time = generators_[i]->Duration();

      // generate profiles with max time
      for (unsigned int i=0; i<generators_.size(); i++)
        generators_[i]->SetProfileDuration(traj_in.points[pnt].positions[i], traj_in.points[pnt+1].positions[i], max_time);

      // copy results in trajectory message
      unsigned int steps = fmax(10, (unsigned int)(max_time / 0.1));
      double time = 0;
      for (unsigned int s=0; s<=steps; s++){
        for (unsigned int i=0; i<generators_.size(); i++){
          points_tmp.positions[i] = generators_[i]->Pos(time);
          points_tmp.velocities[i] = generators_[i]->Vel(time);
          points_tmp.accelerations[i] = generators_[i]->Acc(time);
        }
        points_tmp.time_from_start = ros::Duration(initial_time) + ros::Duration(time);
        traj_res.points.push_back(points_tmp);
        time += max_time/(double)steps;
      }
      initial_time += max_time;
    }
    traj_out = traj_res;
  }



}
