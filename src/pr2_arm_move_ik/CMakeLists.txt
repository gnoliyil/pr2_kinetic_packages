cmake_minimum_required(VERSION 2.8.3)
project(pr2_arm_move_ik)

find_package(catkin REQUIRED COMPONENTS
  roscpp 
  actionlib 
  urdf 
  pr2_common_action_msgs
  geometry_msgs
  tf
  actionlib_msgs
  pr2_controllers_msgs)

catkin_package(
  CATKIN_DEPENDS pr2_common_action_msgs geometry_msgs actionlib_msgs pr2_controllers_msgs)

#
# ESSENTIALS FROM OLD ROSBUILD CMAKELISTS:
#
# rosbuild_add_executable(arm_ik src/arm_ik.cpp)
# rosbuild_add_executable(pr2_arm_ik_test src/test_clients/pr2_arm_ik_test.cpp)
#
