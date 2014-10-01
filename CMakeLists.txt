# Catkin User Guide: http://www.ros.org/doc/groovy/api/catkin/html/user_guide/user_guide.html
# Catkin CMake Standard: http://www.ros.org/doc/groovy/api/catkin/html/user_guide/standards.html
cmake_minimum_required(VERSION 2.8.3)
project(willow_maps)
# Load catkin and all dependencies required for this package
# TODO: remove all from COMPONENTS that are not catkin packages.
find_package(catkin REQUIRED )

# include_directories(include ${Boost_INCLUDE_DIR} ${catkin_INCLUDE_DIRS})
# CATKIN_MIGRATION: removed during catkin migration
# cmake_minimum_required(VERSION 2.4.6)

# CATKIN_MIGRATION: removed during catkin migration
# include($ENV{ROS_ROOT}/core/rosbuild/rosbuild.cmake)

# Set the build type.  Options are:
#  Coverage       : w/ debug symbols, w/o optimization, w/ code-coverage
#  Debug          : w/ debug symbols, w/o optimization
#  Release        : w/o debug symbols, w/ optimization
#  RelWithDebInfo : w/ debug symbols, w/ optimization
#  MinSizeRel     : w/o debug symbols, w/ optimization, stripped binaries
#set(ROS_BUILD_TYPE RelWithDebInfo)


# CATKIN_MIGRATION: removed during catkin migration
# rosbuild_init()

rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-full-0.025.pgm willow-full-0.025.pgm e66b17ee374f2d7657972efcb3e2e4f7)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-full-0.05.pgm willow-full-0.05.pgm b61694296e08965096c5e78611fd9765)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-full-0.10.pgm willow-full-0.10.pgm b84465cdbbfe3e2fb9eb4579e0bcaf0e)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-sans-whitelab-0.025.pgm willow-sans-whitelab-0.025.pgm dce0081e83a9e2eb8b29c51c8cd3ffac)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow.tmap willow.tmap 48864073990c66173dade2bfcae5669d)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-2010-02-18-0.025.pgm willow-2010-02-18-0.025.pgm 1f82c191f1e4a830669de7bbc4bc989a)
rosbuild_download_data(https://code.ros.org/svn/data/trunk/willow_maps/willow-sans-whitelab-2010-02-18-0.025.pgm willow-sans-whitelab-2010-02-18-0.025.pgm 9fc85f28c98034979f10e8f6ece676bb)## Generate added messages and services with any dependencies listed here




#generate_messages(
#    #TODO DEPENDENCIES # TODO add dependencies
#)

# catkin_package parameters: http://ros.org/doc/groovy/api/catkin/html/dev_guide/generated_cmake_api.html#catkin-package
# TODO: fill in what other packages will need to use this package
catkin_package(
    DEPENDS # TODO add dependencies
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS # TODO include
    LIBRARIES # TODO
)





