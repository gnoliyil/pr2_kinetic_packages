cmake_minimum_required(VERSION 2.8.3)
project(pr2_tilt_laser_interface)

find_package(catkin REQUIRED COMPONENTS
  roscpp 
  actionlib 
  actionlib_msgs
  pr2_msgs
  sensor_msgs
  message_generation
  pcl_ros
  pcl_conversions
  laser_geometry)

find_package(Boost REQUIRED COMPONENTS signals)

add_action_files(DIRECTORY action FILES GetSnapshot.action)
generate_messages(DEPENDENCIES actionlib_msgs sensor_msgs pr2_msgs)

catkin_package(
  CATKIN_DEPENDS actionlib_msgs pr2_msgs sensor_msgs message_runtime)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
)

# add_executable(snapshotter src/snapshotter_action.cpp)
# target_link_libraries(snapshotter ${catkin_LIBRARIES})
# add_dependencies(snapshotter ${PROJECT_NAME}_gencpp)

add_executable(grab_result src/grab_result.cpp)
target_link_libraries(grab_result ${catkin_LIBRARIES})
add_dependencies(grab_result ${PROJECT_NAME}_gencpp)
