cmake_minimum_required(VERSION 2.8.12)
project(pr2_unreal_node)

add_definitions(-fPIC)

# catkin dependencies
find_package(catkin
  REQUIRED COMPONENTS 
    angles
    cv_bridge
    diagnostic_msgs
    diagnostic_updater
    geometry_msgs
    image_transport
    message_generation 
    nav_msgs
    polled_camera
    pr2_controller_manager
    pr2_hardware_interface
    pr2_mechanism_msgs
    pr2_mechanism_model
    pr2_msgs
    roscpp
    rospy
    sensor_msgs
    std_msgs
    std_srvs 
    urdf
)

# declare catkin_package
catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS 
    message_runtime
    message_generation
    roscpp 
    rospy 
    angles 
    std_msgs
    nav_msgs
    sensor_msgs
    pr2_mechanism_msgs
    pr2_msgs
    geometry_msgs
    diagnostic_msgs
    urdf 
    tf 
    driver_base 
    image_transport 
  DEPENDS 
    SDF
    orocos_kdl
)

# system dependencies
include (FindPkgConfig)
if (PKG_CONFIG_FOUND)
  pkg_check_modules(XML libxml-2.0)
else()
  message(FATAL_ERROR "pkg-config is required; please install it")
endif()

# Depend on system install of Gazebo and SDFormat
find_package(Boost REQUIRED COMPONENTS thread)
find_package(orocos_kdl)

message(INFO ${catkin_INCLUDE_DIRS})

include_directories(include
  ${Boost_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
)

add_compile_options(-std=c++11)

link_directories(
  ${orocos_kdl_LIBRARY_DIRS}
)

# Gazebo ogre path setup
execute_process(COMMAND
  pkg-config --variable=plugindir OGRE
  OUTPUT_VARIABLE OGRE_PLUGIN_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

# build libraries
add_executable(unreal_ros_node src/unreal_ros_node.cpp)
target_link_libraries(unreal_ros_node ${catkin_LIBRARIES} ${Boost_LIBRARIES})
add_dependencies(unreal_ros_node ${catkin_EXPORTED_TARGETS})

# install libraries
install(
  TARGETS 
    unreal_ros_node
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# test for glx presence for testing
exec_program("glxinfo" OUTPUT_VARIABLE glx_out RETURN_VALUE glx_val)
if(${glx_val} EQUAL 0)
  message(STATUS "run test here")
else(${glx_val} EQUAL 0)
  message(STATUS "no test here")
endif(${glx_val} EQUAL 0)
