cmake_minimum_required(VERSION 2.8.3)
project(pr2_tuck_arms_action)

find_package(catkin REQUIRED COMPONENTS
  actionlib
  actionlib_msgs
  pr2_common_action_msgs
  pr2_controllers_msgs
  rospy
  trajectory_msgs
)

catkin_python_setup()


catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES pr2_tuck_arms_action
  CATKIN_DEPENDS actionlib_msgs pr2_common_action_msgs pr2_controllers_msgs trajectory_msgs
#  DEPENDS system_lib
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

install(PROGRAMS scripts/tuck_arms.py src/pr2_tuck_arms_action/tuck_arms_main.py DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

install(DIRECTORY test/ DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
