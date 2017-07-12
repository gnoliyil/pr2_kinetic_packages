#include <ros/ros.h>
#include <actionlib/client/simple_action_client.h>
#include <actionlib/client/terminal_state.h>
#include <pr2_common_action_msgs/ArmMoveIKAction.h>

int main (int argc, char **argv)
{
  ros::init(argc, argv, "test_pr2_arm_ik");

  // create the action client                                                                                                            
  // true causes the client to spin it's own thread                                                                                      
  actionlib::SimpleActionClient<pr2_common_action_msgs::ArmMoveIKAction> ac("arm_ik", true);

  ROS_INFO("Waiting for action server to start.");
  // wait for the action server to start                                                                                                 
  ac.waitForServer(); //will wait for infinite time                                                                                      

  ROS_INFO("Action server started, sending goal.");
  // send a goal to the action                                                                                                           
  pr2_common_action_msgs::ArmMoveIKGoal goal;
  goal.pose.header.frame_id = "base_link";
  goal.pose.header.stamp = ros::Time::now();
  goal.pose.pose.orientation.x = 0.0;
  goal.pose.pose.orientation.y = 0.0;
  goal.pose.pose.orientation.z = 0.0;
  goal.pose.pose.orientation.w = 1.0;
  goal.pose.pose.position.x = 0.5;
  goal.pose.pose.position.y = -0.1;
  goal.pose.pose.position.z = 0.5;
  goal.ik_timeout = ros::Duration(5.0);
  goal.ik_seed.name.push_back("r_shoulder_pan_joint");
  goal.ik_seed.name.push_back("r_shoulder_lift_joint");
  goal.ik_seed.name.push_back("r_upper_arm_roll_joint");
  goal.ik_seed.name.push_back("r_elbow_flex_joint");
  goal.ik_seed.name.push_back("r_forearm_roll_joint");
  goal.ik_seed.name.push_back("r_wrist_flex_joint");
  goal.ik_seed.name.push_back("r_wrist_roll_joint");
  goal.ik_seed.position.push_back(-1.46);
  goal.ik_seed.position.push_back(1.09);
  goal.ik_seed.position.push_back(-6.58);
  goal.ik_seed.position.push_back(-1.73);
  goal.ik_seed.position.push_back(4.82);
  goal.ik_seed.position.push_back(-0.46);
  goal.ik_seed.position.push_back(-4.72);
  goal.move_duration= ros::Duration(1.0);
  ac.sendGoal(goal);

  //wait for the action to return                                                                                                        
  bool finished_before_timeout = ac.waitForResult(ros::Duration(40.0));

  if (finished_before_timeout)
  {
    actionlib::SimpleClientGoalState state = ac.getState();
    ROS_INFO("Action finished: %s",state.toString().c_str());
  }
  else
    ROS_INFO("Action did not finish before the time out.");

  //exit                                                                                                                                 
  return 0;
}

