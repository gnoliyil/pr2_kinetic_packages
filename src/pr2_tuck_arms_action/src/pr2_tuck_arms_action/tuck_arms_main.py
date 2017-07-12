#!/usr/bin/env python
# Software License Agreement (BSD License)
#
# Copyright (c) 2009, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of the Willow Garage nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Author: Wim Meeussen
# Modified by Jonathan Bohren to be an action and for untucking


import signal

import rospy

import os
import sys
import time
import math

from trajectory_msgs.msg import *
from actionlib_msgs.msg import *
from pr2_controllers_msgs.msg import *
from pr2_common_action_msgs.msg import *
import getopt
import actionlib


# Joint names
joint_names = ["shoulder_pan", 
               "shoulder_lift",
               "upper_arm_roll",
               "elbow_flex", 
               "forearm_roll",
               "wrist_flex", 
               "wrist_roll" ]


l_arm_tucked = [0.06024, 1.248526, 1.789070, -1.683386, -1.7343417, -0.0962141, -0.0864407]
r_arm_tucked = [-0.023593, 1.1072800, -1.5566882, -2.124408, -1.4175, -1.8417, 0.21436]
l_arm_untucked = [ 0.4,  1.0,   0.0,  -2.05,  0.0,  -0.1,  0.0]
r_arm_untucked = [-0.4,  1.0,   0.0,  -2.05,  0.0,  -0.1,  0.0]
r_arm_approach = [0.039, 1.1072, 0.0, -2.067, -1.231, -1.998, 0.369]
r_arm_up_traj = [[-0.4,  0.0,   0.0,  -2.05,  0.0,  -0.1,  0.0]]

# Tuck trajectory
l_arm_tuck_traj = [l_arm_tucked]
r_arm_tuck_traj = [r_arm_approach,
                   r_arm_tucked]

# Untuck trajctory
l_arm_untuck_traj = [l_arm_untucked]
r_arm_untuck_traj = [r_arm_approach,
                     r_arm_untucked]

# clear trajectory
l_arm_clear_traj = [l_arm_untucked]
r_arm_clear_traj = [r_arm_untucked]

class TuckArmsActionServer:
  def __init__(self, node_name):
    self.r_received = False
    self.l_received = False

    self.node_name = node_name

    # arm state: -1 unknown, 0 tucked, 1 untucked
    self.l_arm_state = -1
    self.r_arm_state = -1
    self.success = True

    # Get controller name and start joint trajectory action clients
    self.move_duration = rospy.get_param('~move_duration', 2.5)
    r_action_name = rospy.get_param('~r_joint_trajectory_action', 'r_arm_controller/joint_trajectory_action')
    l_action_name = rospy.get_param('~l_joint_trajectory_action', 'l_arm_controller/joint_trajectory_action')
    self.left_joint_client = client = actionlib.SimpleActionClient(l_action_name, JointTrajectoryAction)
    self.right_joint_client = client = actionlib.SimpleActionClient(r_action_name, JointTrajectoryAction)

    # Connect to controller state
    rospy.Subscriber('l_arm_controller/state', JointTrajectoryControllerState ,self.stateCb)
    rospy.Subscriber('r_arm_controller/state', JointTrajectoryControllerState ,self.stateCb)

    # Wait for joint clients to connect with timeout
    if not self.left_joint_client.wait_for_server(rospy.Duration(30)):
	    rospy.logerr("pr2_tuck_arms: left_joint_client action server did not come up within timelimit")
    if not self.right_joint_client.wait_for_server(rospy.Duration(30)):
	    rospy.logerr("pr2_tuck_arms: right_joint_client action server did not come up within timelimit")

    # Construct action server
    self.action_server = actionlib.simple_action_server.SimpleActionServer(node_name,TuckArmsAction, self.executeCB)


  def executeCB(self, goal):
    # Make sure we received arm state
    while not self.r_received or not self.l_received:
      rospy.sleep(0.1)
      if rospy.is_shutdown():
        return

    # Create a new result
    result = TuckArmsResult()
    result.tuck_left = True
    result.tuck_right = True

    # Tucking left and right arm
    if goal.tuck_right and goal.tuck_left:
      rospy.loginfo('Tucking both arms...')
      self.tuckL()
      self.tuckR()

    # Tucking left arm, untucking right arm
    elif goal.tuck_left and not goal.tuck_right:
      rospy.loginfo('Tucking left arm and untucking right arm...')
      self.untuckR()
      self.tuckL()

    # Tucking right arm, untucking left arm
    if goal.tuck_right and not goal.tuck_left:
      rospy.loginfo('Tucking right arm and untucking left arm...')        
      self.untuckL()
      self.tuckR()

    # UnTucking both arms
    if not goal.tuck_right and not goal.tuck_left:
      rospy.loginfo("Untucking both arms...")
      self.untuckL()
      self.untuckR()

    # Succeed or fail
    if self.success:
      result.tuck_right = goal.tuck_right
      result.tuck_left = goal.tuck_left
      self.action_server.set_succeeded(result)
    else:
      rospy.logerr("Tuck or untuck arms FAILED: Right value: %d. Left value: %d" % (result.tuck_left, result.tuck_right))
      result.tuck_right = (self.r_arm_state == 0)
      result.tuck_left = (self.l_arm_state == 0)
      self.action_server.set_aborted(result)


  # clears r arm and l arm
  def tuckL(self):
    if self.l_arm_state != 0:
      self.go('r', r_arm_up_traj)
      if self.l_arm_state != 1:
        self.go('l', l_arm_clear_traj)
      self.go('l', l_arm_tuck_traj)
      self.go('r', r_arm_clear_traj)
    
  # clears r arm
  def untuckL(self):
    if self.l_arm_state != 1:
      self.go('r', r_arm_up_traj)
      if self.l_arm_state == 0:
        self.go('l', l_arm_untuck_traj)
      elif self.l_arm_state == -1:
        self.go('l', l_arm_clear_traj)

  # assumes l tucked or cleared
  def tuckR(self):
    if self.r_arm_state != 0:
      self.go('r', r_arm_tuck_traj)

  # assumes l tucked or cleared
  def untuckR(self):
    if self.r_arm_state == 0:
      self.go('r', r_arm_untuck_traj)
    elif self.r_arm_state == -1:
      self.go('r', r_arm_clear_traj)

  def go(self, side, positions, wait = True):
    goal = JointTrajectoryGoal()
    goal.trajectory.joint_names = [side+"_"+name+"_joint" for name in joint_names]
    goal.trajectory.points = []
    for p, count in zip(positions, range(0,len(positions)+1)):
      goal.trajectory.points.append(JointTrajectoryPoint( positions = p,
                                                          velocities = [],
                                                          accelerations = [],
                                                          time_from_start = rospy.Duration((count+1) * self.move_duration)))
    goal.trajectory.header.stamp = rospy.get_rostime() + rospy.Duration(0.01)
    if wait:
      if not {'l': self.left_joint_client, 'r': self.right_joint_client}[side].send_goal_and_wait(goal, rospy.Duration(30.0), rospy.Duration(5.0)):
        self.success = False
    else:
      {'l': self.left_joint_client, 'r': self.right_joint_client}[side].send_goal(goal)


  # Returns angle between -pi and + pi
  def angleWrap(self, angle):
    while angle > math.pi:
      angle -= math.pi*2.0
    while angle < -math.pi:
      angle += math.pi*2.0
    return angle


  def stateCb(self, msg):
    l_sum_tucked = 0
    l_sum_untucked = 0
    r_sum_tucked = 0
    r_sum_untucked = 0
    for name_state, name_desi, value_state, value_l_tucked, value_l_untucked, value_r_tucked, value_r_untucked in zip(msg.joint_names, joint_names, msg.actual.positions , l_arm_tucked, l_arm_untucked, r_arm_tucked, r_arm_untucked):
      value_state = self.angleWrap(value_state)

      if 'l_'+name_desi+'_joint' == name_state:
        self.l_received = True
        l_sum_tucked = l_sum_tucked + math.fabs(value_state - value_l_tucked)
        l_sum_untucked = l_sum_untucked + math.fabs(value_state - value_l_untucked)
      if 'r_'+name_desi+'_joint' == name_state:
        self.r_received = True
        r_sum_tucked = r_sum_tucked + math.fabs(value_state - value_r_tucked)
        r_sum_untucked = r_sum_untucked + math.fabs(value_state - value_r_untucked)

    if l_sum_tucked > 0 and l_sum_tucked < 0.1:
      self.l_arm_state = 0
    elif l_sum_untucked > 0 and l_sum_untucked < 0.3:
      self.l_arm_state = 1
    elif l_sum_tucked >= 0.1 and l_sum_untucked >= 0.3:
      self.l_arm_state = -1    

    if r_sum_tucked > 0 and r_sum_tucked < 0.1:
      self.r_arm_state = 0
    elif r_sum_untucked > 0 and r_sum_untucked < 0.3:
      self.r_arm_state = 1
    elif r_sum_tucked >= 0.1 and r_sum_untucked >= 0.3:
      self.r_arm_state = -1    


def main():
  action_name = 'tuck_arms'
  rospy.init_node(action_name)
  rospy.sleep(0.001)  # wait for time
  tuck_arms_action_server = TuckArmsActionServer(action_name)

  rospy.spin()


if __name__ == '__main__':
  main()
