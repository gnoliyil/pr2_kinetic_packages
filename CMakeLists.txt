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


install(PROGRAMS /src/app_manager/app.py /src/app_manager/app_manager.py /src/app_manager/app_list.py /src/app_manager/exchange.py /src/app_manager/exceptions.py /src/app_manager/__init__.py /src/app_manager/master_sync.py /src/app_manager/srv/_StartApp.py /src/app_manager/srv/_UninstallApp.py /src/app_manager/srv/_GetInstallationState.py /src/app_manager/srv/_InstallApp.py /src/app_manager/srv/_StopApp.py /src/app_manager/srv/_ListApps.py /src/app_manager/srv/__init__.py /src/app_manager/srv/_GetAppDetails.py /src/app_manager/msg/_AppList.py /src/app_manager/msg/_AppStatus.py /src/app_manager/msg/_KeyValue.py /src/app_manager/msg/_StatusCodes.py /src/app_manager/msg/_AppInstallationState.py /src/app_manager/msg/_ClientApp.py /src/app_manager/msg/_ExchangeApp.py /src/app_manager/msg/_App.py /src/app_manager/msg/__init__.py /src/app_manager/msg/_Icon.py /test/test_app.py /test/test_app_list.py /scripts/test_app.py  USE_SOURCE_PERMISSIONS 
 DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
install(DIRECTORY src srv srv_gen test msg_gen msg lib bin scripts app_manager srv msg cpp lisp include app_manager applistbad applist1 cpp lisp include app_manager  
 DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})



