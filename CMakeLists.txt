cmake_minimum_required(VERSION 2.8.3)
project(app_manager)
find_package(catkin REQUIRED COMPONENTS message_runtime std_msgs rospy roslaunch rosgraph rosunit message_generation)

catkin_add_nosetests(test/test_app.py)
catkin_add_nosetests(test/test_app_list.py)
add_message_files(
    FILES 
    AppList.msg
    ClientApp.msg
    AppInstallationState.msg
    App.msg
    KeyValue.msg
    AppStatus.msg
    ExchangeApp.msg
    Icon.msg
    StatusCodes.msg
)
add_service_files(
    FILES 
    GetAppDetails.srv
    ListApps.srv
    UninstallApp.srv
    InstallApp.srv
    GetInstallationState.srv
    StartApp.srv
    StopApp.srv
)


generate_messages(
    DEPENDENCIES std_msgs 
)

catkin_package(
    DEPENDS rospy roslaunch rosgraph rosunit
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS # TODO include
    LIBRARIES # TODO
)


install(PROGRAMS scripts/app_manager scripts/rosget scripts/test_app.py
 DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
install(DIRECTORY msg msg_gen scripts src srv srv_gen test
 DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})



