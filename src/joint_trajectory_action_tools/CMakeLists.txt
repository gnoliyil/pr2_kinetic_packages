cmake_minimum_required(VERSION 2.8.3)
project(joint_trajectory_action_tools)

find_package(catkin REQUIRED COMPONENTS 
  roslib 
  rospy
  joint_trajectory_action
  trajectory_msgs
  pr2_controllers_msgs
)

catkin_python_setup()

catkin_package(
  CATKIN_DEPENDS trajectory_msgs pr2_controllers_msgs)

install(DIRECTORY config/ DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})

install(DIRECTORY test/ DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
