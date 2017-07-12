#!/usr/bin/env python  

import roslib; roslib.load_manifest('pr2_plugs_actions')
import rospy
from joint_trajectory_action_tools.tools import *

if __name__ == '__main__':
  rospy.init_node('joint_trajectory_action_tools')
  print get_action_goal('move_from_outlet')
  rospy.spin()
