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
 *   * Redistributions in binary form must reproduce the above               \
                                                                              
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
 * Author: Melonee Wise                                                       
 *********************************************************************/

#ifndef TRAJECTORY_UNWRAP_H_
#define TRAJECTORY_UNWRAP_H_

#include <angles/angles.h>
#include <urdf/model.h>
#include <urdf/joint.h>
#include <trajectory_msgs/JointTrajectory.h>

namespace trajectory_unwrap
{

void unwrap(urdf::Model &robot_model, const trajectory_msgs::JointTrajectory& traj_in, 
                         trajectory_msgs::JointTrajectory& traj_out)
{
  //defualt result
  traj_out = traj_in;
 
  int num_jnts = traj_in.joint_names.size();
  int traj_pnts = traj_in.points.size(); 
  boost::shared_ptr<const urdf::Joint> joint;

  for(int i=0; i<num_jnts; i++)
  {
    joint = robot_model.getJoint(traj_in.joint_names[i]);
    if(joint->type == urdf::Joint::REVOLUTE)
    {
      for(int j=1; j<traj_pnts; j++)
      {
        double diff;

        angles::shortest_angular_distance_with_limits(traj_out.points[j-1].positions[i], traj_out.points[j].positions[i], joint->limits->lower, joint->limits->upper, diff);
        traj_out.points[j].positions[i] = traj_out.points[j-1].positions[i] + diff;
      }
    }
    if(joint->type == urdf::Joint::CONTINUOUS)
    {
      for(int j=1; j<traj_pnts; j++)
      {
        traj_out.points[j].positions[i] = traj_out.points[j-1].positions[i] + angles::shortest_angular_distance(traj_out.points[j-1].positions[i],traj_out.points[j].positions[i]);
      }
    }
  }
}
}
#endif
