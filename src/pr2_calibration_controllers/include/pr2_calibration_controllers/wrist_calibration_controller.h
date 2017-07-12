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
 */

/*
 * Author: Stuart Glaser
 */

#ifndef WRIST_CALIBRATION_CONTROLLER_H
#define WRIST_CALIBRATION_CONTROLLER_H

#include "robot_mechanism_controllers/joint_velocity_controller.h"
#include "realtime_tools/realtime_publisher.h"
#include "pr2_mechanism_model/wrist_transmission.h"
#include "std_msgs/Empty.h"
#include "pr2_controllers_msgs/QueryCalibrationState.h"

namespace controller {

class WristCalibrationController : public pr2_controller_interface::Controller
{
public:
  WristCalibrationController();
  ~WristCalibrationController();

  virtual bool init(pr2_mechanism_model::RobotState *robot, ros::NodeHandle &n);
  virtual void starting();
  virtual void update();

  bool isCalibrated(pr2_controllers_msgs::QueryCalibrationState::Request& req, pr2_controllers_msgs::QueryCalibrationState::Response& resp);

protected:

  enum { INITIALIZED, BEGINNING,
         MOVING_FLEX_TO_HIGH, MOVING_FLEX,
         MOVING_ROLL_TO_LOW, MOVING_ROLL, CALIBRATED };
  int state_;

  pr2_mechanism_model::RobotState *robot_;
  ros::NodeHandle node_;
  ros::Time last_publish_time_;
  ros::ServiceServer is_calibrated_srv_;
  boost::scoped_ptr<realtime_tools::RealtimePublisher<std_msgs::Empty> > pub_calibrated_;

  double roll_search_velocity_;
  double flex_search_velocity_;
  bool original_switch_state_;
  int countdown_;

  // Tracks the actuator positions for when the optical switch occurred.
  double flex_switch_l_, flex_switch_r_;
  double roll_switch_l_, roll_switch_r_;

  double prev_actuator_l_position_, prev_actuator_r_position_;

  pr2_hardware_interface::Actuator *actuator_l_, *actuator_r_;
  pr2_mechanism_model::JointState *flex_joint_, *roll_joint_;
  boost::shared_ptr<pr2_mechanism_model::Transmission> transmission_;

  // Preallocated, for use in update()
  std::vector<pr2_hardware_interface::Actuator*> fake_as;
  std::vector<pr2_mechanism_model::JointState*> fake_js;

  controller::JointVelocityController vc_flex_, vc_roll_;
};


}

#endif
