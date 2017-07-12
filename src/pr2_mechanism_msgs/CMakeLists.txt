cmake_minimum_required(VERSION 2.8.3)
project(pr2_mechanism_msgs)

find_package(catkin REQUIRED
  message_generation
  std_msgs
  actionlib_msgs
  )

add_action_files(DIRECTORY action FILES
  SwitchController.action
  )

add_message_files(DIRECTORY msg FILES
  ActuatorStatistics.msg
  ControllerStatistics.msg
  JointStatistics.msg
  MechanismStatistics.msg
  )

add_service_files(DIRECTORY srv FILES
  ListControllers.srv
  LoadController.srv
  SwitchController.srv
  ListControllerTypes.srv
  ReloadControllerLibraries.srv
  UnloadController.srv
)

generate_messages(DEPENDENCIES std_msgs actionlib_msgs)

catkin_package(
  CATKIN_DEPENDS message_runtime
)
