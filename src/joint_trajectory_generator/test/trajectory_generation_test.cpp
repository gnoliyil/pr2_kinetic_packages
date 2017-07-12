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

#include <joint_trajectory_generator/trajectory_generation.h>
#include <trajectory_msgs/JointTrajectory.h>
#include <ros/ros.h>
#include <iostream>

using namespace std;

void printTraj(const trajectory_msgs::JointTrajectory& traj)
{
  cout << "Trajectory:" << endl;
  cout << " - Joints: " << endl;
  for (unsigned int i=0; i<traj.joint_names.size(); i++)
    cout << "    - " << traj.joint_names[i] << endl;
  cout << " - Points: " << endl;
  for (unsigned int i=0; i<traj.points.size(); i++){
    cout << "     - Time from start: " << traj.points[i].time_from_start.toSec()<< endl;
    cout << "     - Positions: " << endl;
    for (unsigned int j=0; j<traj.points[i].positions.size(); j++)
      cout << "      - " << traj.points[i].positions[j] << endl;
    cout << "     - Velocities: " << endl;
    for (unsigned int j=0; j<traj.points[i].velocities.size(); j++)
      cout << "      - " << traj.points[i].velocities[j] << endl;
    cout << "     - Accelerations: " << endl;
    for (unsigned int j=0; j<traj.points[i].accelerations.size(); j++)
      cout << "      - " << traj.points[i].accelerations[j] << endl;
  }
}



int main(int argc, char** argv)
{
  ros::init(argc, argv, "trajectory_generation_test");

  // create test trajectory
  trajectory_msgs::JointTrajectory traj_in, traj_out;;
  traj_in.header.stamp = ros::Time::now();
  traj_in.joint_names.resize(3);
  traj_in.joint_names[0] = "wim1";
  traj_in.joint_names[1] = "wim2";
  traj_in.joint_names[2] = "wim3";
  traj_in.points.resize(3);

  traj_in.points[0].positions.resize(3);
  traj_in.points[0].time_from_start = ros::Duration(1.0);
  traj_in.points[0].positions[0] = 0.0;
  traj_in.points[0].positions[1] = 0.0;
  traj_in.points[0].positions[2] = 0.0;

  traj_in.points[1].positions.resize(3);
  traj_in.points[1].time_from_start = ros::Duration(2.0);
  traj_in.points[1].positions[0] = 1.0;
  traj_in.points[1].positions[1] = 1.0;
  traj_in.points[1].positions[2] = 1.0;

  traj_in.points[2].positions.resize(3);
  traj_in.points[2].time_from_start = ros::Duration(2.0);
  traj_in.points[2].positions[0] = 2.0;
  traj_in.points[2].positions[1] = 2.0;
  traj_in.points[2].positions[2] = 2.0;
  printTraj(traj_in);

  // create trajectory generator
  trajectory::TrajectoryGenerator generator(0.1, 0.5, 3);
  generator.generate(traj_in, traj_out);
  printTraj(traj_out);
  
  return 0;
}
