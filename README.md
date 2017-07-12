# PR2 Packages for ROS Kinetic Kame

Yilong Li 

This is a catkin workspace for PR2 packages which can be run on ROS version Kinetic Kame.

## Installation and Usage

__Step 1.__ Install dependency packages: `ros-kinetic-pr2-common` `ros-kinetic-pr2-description` `ros-kinetic-pr2-machine` `ros-kinetic-pr2-msgs` and `ros-kinetic-moveit` are required; Download EML(EtherCAT Master for Linux) from [this repository](https://github.com/ros-gbp/eml-release/tree/release/hydro/eml/eml-svn) (in release/hydro/eml branch) and run 
``` bash
    $ mkdir build
    $ cd build
    $ cmake ..; make; sudo make install 
```
to install the EML library. 

__Step 2.__ Build all packages in __isolated__ mode. (Normal mode doesn't work for me, some service headers are not found)
``` bash
    $ catkin_make_isolated
```

If you see the error message like 
```
CMake Error at /opt/ros/kinetic/share/catkin/cmake/catkinConfig.cmake:83 (find_package):
  Could not find a package configuration file provided by "moveit_msgs" with
  any of the following names:

    moveit_msgsConfig.cmake
    moveit_msgs-config.cmake
```
It means you need to install other dependency packages from apt-get. 

__Step 3.__ Set environment variables using `source devel_isolated/setup.sh`. You can add it in your `.bashrc` file. 

## Packages 

These packages are included: 

- `pr2_robot` (Source: https://github.com/PR2/pr2\_robot)
  - `imu_monitor` 
  - `pr2_bringup`
  - `pr2_camera_synchronizer` 
  - `pr2_computer_monitor`
  - `pr2_controller_configuration`
  - `pr2_ethercat`
  - `pr2_run_stop_auto_restart`
- `pr2_controllers`: (Source: https://github.com/pr2/pr2\_controllers)
  - `control_toolbox`
  - `ethercat_trigger_controllers`
  - `joint_trajectory_action`
  - `pr2_calibration_controllers`
  - `pr2_controllers_msgs`
  - `pr2_gripper_action`
  - `pr2_head_action`
  - `pr2_mechanism_controllers`
  - `robot_mechanism_controllers`
  - `single_joint_position_action`
- `pr2_ethercat_drivers`: (Source: https://github.com/PR2/pr2\_ethercat\_drivers)
  - `ethercat_hardware`
  - `fingertip_pressure`
- `pr2_common_actions`: (Source: https://github.com/pr2/pr2\_common\_actions)
  - `joint_trajectory_action_tools`
  - `joint_trajectory_generator`
  - `pr2_arm_move_ik`
  - `pr2_common_action_msgs`
  - `pr2_tilt_laser_interface`
  - `pr2_tuck_arms_action`
- `pr2_power_drivers`: (Source: https://github.com/pr2/pr2\_power\_drivers)
  - `ocean_battery_driver`
  - `power_monitor`
  - `pr2_power_board`
- `pr2_apps`: (Source: https://github.com/pr2/pr2\_apps)
  - `pr2_app_manager`
  - `pr2_mannequin_mode`
  - `pr2_position_scripts`
  - `pr2_teleop`
  - `pr2_teleop_general`
  - `pr2_tuckarm`
- `pr2_simulator`: (Source: https://github.com/PR2/pr2\_simulator)
  - `pr2_controller_configuration_gazebo`
  - `pr2_gazebo`
  - `pr2_gazebo_plugins`
- `pr2_mechanism`: (Source: https://github.com/pr2/pr2\_mechanism)
  - `pr2_controller_interface`
  - `pr2_controller_manager`
  - `pr2_hardware_interface`
  - `pr2_mechanism_diagnostics`
  - `pr2_mechanism_model`
- `app_manager` (Source: https://github.com/pr2/app\_manager) 
- `moveit_msgs` (Source: https://github.com/ros-planning/moveit\_msgs)
- `willow_maps` (Source: https://github.com/pr2/willow\_maps)

## Notes

1. Add a `RobotState::RobotState()` constructor (though should never be called) for compatibility with new version of `hardware_interface`. 

2. Add `pr2_controllers_msgs` to dependency lists of `joint_trajectory_generator` (both in CMakeLists.txt and packages.xml) 

3. Use `jade-devel` branch of `moveit_msgs` rather than `kinetic-devel`, since the latter one removes `GetKinematicSolverInfo.srv`, which is required by pr2 package `pr2_teleop`. 
