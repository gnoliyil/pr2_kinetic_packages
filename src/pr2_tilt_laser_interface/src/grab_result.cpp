#include <ros/ros.h>
#include <pr2_tilt_laser_interface/GetSnapshotActionResult.h>
#include <pr2_tilt_laser_interface/GetSnapshotActionFeedback.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl/io/pcd_io.h>

ros::Publisher pub;
void 
  resultCallback(const pr2_tilt_laser_interface::GetSnapshotActionResultConstPtr& action_result)
{
  if (action_result->result.cloud.height*action_result->result.cloud.height == 0)
    return;
  pub.publish (action_result->result.cloud);
  ROS_INFO ("Published point cloud from action result!\n");
}

void 
  feedbackCallback(const pr2_tilt_laser_interface::GetSnapshotActionFeedbackConstPtr& action_feedback)
{
  if (action_feedback->feedback.cloud.height*action_feedback->feedback.cloud.height == 0)
    return;
  pub.publish (action_feedback->feedback.cloud);
  ROS_INFO ("Published point cloud from action feedback!\n");
}

int 
  main (int argc, char** argv)
{
  ros::init (argc, argv, "result_grabber");
  ros::NodeHandle nh;
  pub = nh.advertise<sensor_msgs::PointCloud2>("snapshot", 1, true);
  ros::Subscriber result_subscriber = nh.subscribe("get_laser_snapshot/result", 1, resultCallback);
  ros::Subscriber feedback_subscriber = nh.subscribe("get_laser_snapshot/feedback", 1, feedbackCallback);
  
  ROS_INFO ("Waiting for cloud to come in over ROS");
  ros::spin();


  //while (nh.ok ())
  //{
    //ROS_INFO ("Waiting for cloud to come in over ROS");
    //pr2_tilt_laser_interface::GetSnapshotActionResultConstPtr action_result = ros::topic::waitForMessage<pr2_tilt_laser_interface::GetSnapshotActionResult>("get_laser_snapshot/result");
    //sensor_msgs::PointCloud2 cloud = action_result->result.cloud;

    //pub.publish (cloud);
    //ROS_INFO ("Published the point cloud!\n");
    //ros::spinOnce ();
    //ros::Duration (0.5).sleep ();
  //}

  return (0);
}
