cmake_minimum_required(VERSION 2.8.3)
project(joint_trajectory_generator)

find_package(catkin REQUIRED COMPONENTS 
  roscpp 
  urdf 
  angles
  actionlib
  joint_trajectory_action
  pr2_controllers_msgs
)

find_package(Boost REQUIRED COMPONENTS thread)
find_package(orocos_kdl REQUIRED)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES joint_trajectory_generation
  CATKIN_DEPENDS roscpp urdf angles actionlib joint_trajectory_action pr2_controllers_msgs
  DEPENDS Boost orocos_kdl)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
  ${orocos_kdl_INCLUDE_DIRS})

add_library(joint_trajectory_generation 
  src/trajectory_generation.cpp)
target_link_libraries(joint_trajectory_generation
  ${catkin_LIBRARIES}
  ${orocos_kdl_LIBRARIES})

add_executable(${PROJECT_NAME} 
  src/joint_trajectory_generator.cpp)
target_link_libraries(${PROJECT_NAME}
  ${catkin_LIBRARIES} 
  ${orocos_kdl_LIBRARIES}
  joint_trajectory_generation)

install(TARGETS ${PROJECT_NAME}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})

install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  FILES_MATCHING PATTERN "*.h"
  PATTERN ".svn" EXCLUDE)

install(TARGETS joint_trajectory_generation 
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION})
