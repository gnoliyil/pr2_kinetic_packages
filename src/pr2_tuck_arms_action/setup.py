from distutils.core import setup
from catkin_pkg.python_setup import generate_distutils_setup

d = generate_distutils_setup(
    packages=['pr2_tuck_arms_action'],
    package_dir={'': 'src'},
    requires=['actionlib', 'actionlib_msgs', 'pr2_common_action_msgs', 'pr2_controllers_msgs', 'rospy', 'trajectory_msgs'],
    scripts=['scripts/tuck_arms.py']
)

setup(**d)
