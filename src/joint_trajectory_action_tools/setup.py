from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['joint_trajectory_action_tools'],
    package_dir={'': 'src'},
    requires=['roslib', 'rospy', 'joint_trajectory_action', 'trajectory_msgs', 'pr2_controllers_msgs'],
    scripts=[]
)

setup(**d)
