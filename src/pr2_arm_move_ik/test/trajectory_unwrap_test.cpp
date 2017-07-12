/*                                                                                
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
 * 
 * Author: Melonee Wise
 */

#include <ros/ros.h>
#include <gtest/gtest.h>
#include <urdf/model.h>
#include <trajectory_msgs/JointTrajectory.h>
#include <pr2_arm_ik_action/trajectory_unwrap.h>

bool get_model(urdf::Model& robot)
{
  ros::NodeHandle nh;
  std::string file;
  nh.getParam("urdf_file_path", file);
  TiXmlDocument robot_model_xml;
  robot_model_xml.LoadFile(file);
  TiXmlElement *robot_xml = robot_model_xml.FirstChildElement("robot");
  if (!robot_xml){
    std::cerr << "ERROR: Could not load the xml into TiXmlElement" << std::endl;
    return false;
  }

  if (!robot.initXml(robot_xml)){
    std::cerr << "ERROR: Model Parsing the xml failed" << std::endl;
    return false;
  }
  return true;
}


TEST(TrajectoryUnwarp, single_unwrap)
{
  double epsilon = 1e-4;
  urdf::Model robot;
  EXPECT_TRUE(get_model(robot));

  trajectory_msgs::JointTrajectory traj_in, traj_out, traj_expected;
  
  traj_in.points.resize(2);
  traj_in.joint_names.push_back("joint1");
  traj_in.joint_names.push_back("joint2");
  traj_in.points[0].positions.push_back(0.0);
  traj_in.points[0].positions.push_back(0.0);
  traj_in.points[1].positions.push_back(12.0);  
  traj_in.points[1].positions.push_back(0.0);


  traj_expected =traj_in;
  traj_expected.points[1].positions[0]=-0.566371;
  trajectory_unwrap::unwrap(robot, traj_in, traj_out);
 
  int points_size = traj_out.points.size();
  int num_jnts = traj_out.points[0].positions.size();

  for(int i=0; i<points_size; i++)
  {
    for(int j=0; j<num_jnts; j++)
    {
      EXPECT_NEAR(traj_expected.points[i].positions[j],traj_out.points[i].positions[j], epsilon);
    }
  }
}

TEST(TrajectoryUnwarp, double_unwrap)
{
  double epsilon = 1e-4;
  urdf::Model robot;
  EXPECT_TRUE(get_model(robot));

  trajectory_msgs::JointTrajectory traj_in, traj_out, traj_expected;

  traj_in.points.resize(2);
  traj_in.joint_names.push_back("joint1");
  traj_in.joint_names.push_back("joint3");
  traj_in.points[0].positions.push_back(0.0);
  traj_in.points[0].positions.push_back(6.10);
  traj_in.points[1].positions.push_back(12.0);
  traj_in.points[1].positions.push_back(12.0);

  traj_expected =traj_in;
  traj_expected.points[1].positions[0]=-0.566371;
  traj_expected.points[1].positions[1]= 5.71682;
  trajectory_unwrap::unwrap(robot, traj_in, traj_out);

  int points_size = traj_out.points.size();
  int num_jnts = traj_out.points[0].positions.size();

  for(int i=0; i<points_size; i++)
  {
    for(int j=0; j<num_jnts; j++)
    {
      EXPECT_NEAR(traj_expected.points[i].positions[j],traj_out.points[i].positions[j], epsilon);
    }
  }
}

TEST(TrajectoryUnwarp, multipoint_unwrap)
{
  double epsilon = 1e-4;
  urdf::Model robot;
  EXPECT_TRUE(get_model(robot));

  trajectory_msgs::JointTrajectory traj_in, traj_out, traj_expected;

  traj_in.points.resize(3);
  traj_in.joint_names.push_back("joint1");
  traj_in.joint_names.push_back("joint3");
  traj_in.points[0].positions.push_back(0.0);
  traj_in.points[0].positions.push_back(6.10);
  traj_in.points[1].positions.push_back(12.0);
  traj_in.points[1].positions.push_back(12.0);
  traj_in.points[2].positions.push_back(1.5);
  traj_in.points[2].positions.push_back(1.5);

  traj_expected =traj_in;
  traj_expected.points[1].positions[0]=-0.566371;
  traj_expected.points[1].positions[1]= 5.71682;
  traj_expected.points[2].positions[1]= 7.78318;
  trajectory_unwrap::unwrap(robot, traj_in, traj_out);

  int points_size = traj_out.points.size();
  int num_jnts = traj_out.points[0].positions.size();

  for(int i=0; i<points_size; i++)
  {
    for(int j=0; j<num_jnts; j++)
    {
      EXPECT_NEAR(traj_expected.points[i].positions[j],traj_out.points[i].positions[j], epsilon);
    }
  }
}

TEST(TrajectoryUnwarp, near_limit_unwrap)
{
  double epsilon = 1e-4;
  urdf::Model robot;
  EXPECT_TRUE(get_model(robot));

  trajectory_msgs::JointTrajectory traj_in, traj_out, traj_expected;

  traj_in.points.resize(3);
  traj_in.joint_names.push_back("joint2");
  traj_in.points[0].positions.push_back(-1.5);
  traj_in.points[1].positions.push_back(-3.5);
  traj_in.points[2].positions.push_back(1.7);

  traj_expected =traj_in;
  traj_expected.points[1].positions[0]= 2.78318;
  traj_expected.points[2].positions[0]= 1.7;
  trajectory_unwrap::unwrap(robot, traj_in, traj_out);

  int points_size = traj_out.points.size();
  int num_jnts = traj_out.points[0].positions.size();

  for(int i=0; i<points_size; i++)
  {
    for(int j=0; j<num_jnts; j++)
    {
      EXPECT_NEAR(traj_expected.points[i].positions[j],traj_out.points[i].positions[j], epsilon);
    }
  }
}





int main(int argc, char **argv){
  testing::InitGoogleTest(&argc, argv);
  ros::init(argc, argv, "trajectory_unwrap_test");
  return RUN_ALL_TESTS();
}
