#include <ros/ros.h>
#include <math.h>
#include <hector_uav_msgs/EnableMotors.h>
#include <hector_uav_msgs/YawrateCommand.h>
#include <hector_uav_msgs/ThrustCommand.h>
#include <hector_uav_msgs/AttitudeCommand.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Vector3Stamped.h>
#include <geometry_msgs/Twist.h>

float angle_min = -2.3561899662; //　雷达数据的起始角度（最小角度）
float angle_max = 2.3561899662;//　雷达数据的终止角度（最大角度）
float angle_increment = 0.00436331471428;  //　雷达数据的角度分辨率（角度增量）

//存储姿态以及位置 
float pose_x = 0;
float pose_y = 0;
float pose_z = 0;
float vector_x = 0; 
float vector_y = 0;
float vector_z = 0;


//期望控制高度 
float pose_z_h = 2;

//初始化控制姿态的参数 
float vel_z = 0; //速度
float vel_x = 0; //速度  ///  降速 
float ac_z = 0.2; 
float angle_dir = 0; //初始化定义航向期望角 
float dis_max = 0;
int ranges_size = 0;
int index_max = 0;

// 回调函数，获取激光扫描数据，找出其中的最大距离值，并据此计算无人机的航向期望值。
void scanCallback(const sensor_msgs::LaserScan::ConstPtr& msg){
    ranges_size = (780>msg->ranges.size())? msg->ranges.size(): 780;
	//这段代码的作用是将ranges_size设置为msg->ranges.size()和780中较小的那个值。
	//float32[] ranges　雷达数据每个点对应的在极坐标系下的距离值 [m]
    dis_max = 0;//dis_max为距离最大值 
    int i = 0;
    for (; i< ranges_size; ++i){
        if(isinf(msg->ranges[i]) == 0){
          if(msg->ranges[i]> dis_max){
              dis_max = msg->ranges[i];
              index_max = i;//选出最大值以及最大值对应的位置 
          }
        }
    }
    angle_dir = angle_min + angle_increment * index_max;//算出与0°相差的航向值
}

//ROS中用于处理机器人位姿（位置和姿态）信息的回调函数
//提取出x、y、z坐标值，分别存储到全局变量pose_x、pose_y、pose_z
void PoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg){
    pose_x = msg->pose.position.x;
    pose_y = msg->pose.position.y;
    pose_z = msg->pose.position.z;
}

void VectorCallback(const geometry_msgs::Vector3Stamped::ConstPtr& msg){ 
	vector_x = msg->vector.x;  
    vector_y = msg->vector.y;  
    vector_z = msg->vector.z;  
}

//根据期望高度和实际高度进行高度控制，低升高降 
float PIDCtrl_height(float pose_z, float pose_z_h){
	if (fabs(pose_z_h - pose_z )<0.5){ 
        return pose_z_h - pose_z;
    }
    else if(pose_z_h - pose_z>0.5){
        return 0.5;
    }
    else{
    	return -0.5;
	}
}

//根据相差角进行航向控制，dir为体轴系下角度，与头航向夹角，最后期望变成0 
float PIDCtrl_dir(float angle_dir) {
	if (fabs(angle_dir)< angle_increment){
        return -angle_dir;
    }
    else if(fabs(angle_dir)<0.2){
        return -angle_dir;
    }
    else if(angle_dir >0){
    	return -0.2;
	}
    else {
       return 0.2;
    }
}

int main(int argc, char** argv){
    ros::init(argc,argv,"hector_ctrl_node");//初始化节点 
    ros::NodeHandle nh;//创建节点句柄，管理节点的资源，指定全局空间 
    ros::Publisher velocity_publisher_;//创建话题通讯机制 
    ros::ServiceClient motor_enable_service_;//创建一个服务通讯 
    ros::Rate loop_rate(10); //设置循坏的频率是10hz
    ros::Publisher cmd_vel_pub = nh.advertise<geometry_msgs::Twist>("/cmd_vel",1000);
	//创建一个Publisher，发布名为/cmd_vel的topic，消息类型为geometry_msgs::Twist，队列长度1000 
    motor_enable_service_ = nh.serviceClient<hector_uav_msgs::EnableMotors>("enable_motors");
    if(!motor_enable_service_.waitForExistence(ros::Duration(5.0))){
        ROS_WARN("motor enable service not found");
        return false;
    }
    /*同上，命名这个serves的名称并且规定消息类型；
	由于Service通信的特殊性，加一个client.waitForExistence()这类阻塞式函数可以保证启动和调用的顺序*/ 
    ros::Subscriber subScan = nh.subscribe("/scan",50, scanCallback); //0.25s的更新频率
    ros::Subscriber subPose = nh.subscribe("/ground_truth_to_tf/pose",50, PoseCallback); //0.25s 的更新频率
    ros::Subscriber subVector3 = nh.subscribe("/ground_truth_to_tf/euler",50, VectorCallback); ///
    // 订阅 /scan、 /ground_truth_to_tf/pose两个话题 
    hector_uav_msgs::EnableMotors srv;
    srv.request.enable = true;//导入hector_uav_msgs信息包，里面含有一些senor_msg里面没有的信息 
    motor_enable_service_.call(srv);//将srv调用至定义的服务通讯中 
    while(ros::ok()){//确认状态，当按下ctr+C或者别的一些异常情况时，其值才可能是FALSE
    	ros::Duration(2).sleep();//等待两秒钟无人机启动 
        geometry_msgs::Twist cmd_vel_msg;//使用Twist类型的数据来控制无人机的运动 
        vel_z = PIDCtrl_height(pose_z, pose_z_h);//使无人机保持在2m高度 
        vel_x = 0.07*(dis_max-3.7);//使无人机前进一段距离的同时不撞到障碍物 
        ac_z = PIDCtrl_dir(angle_dir);
        cmd_vel_msg.linear.z = vel_z;
		cmd_vel_msg.angular.z = ac_z;
        cmd_vel_msg.linear.x = vel_x;
        //用更新的位置、角度等参数的变化使无人机运动
		//保持无人机稳定 
        ROS_INFO("vel z is %f, vel x is %f, angular z is %f\n", vel_z, vel_x, ac_z);//输出控制的数据信息
        cmd_vel_pub.publish(cmd_vel_msg);//更新
        ros::spinOnce();//将数据代入回调函数循环 
        loop_rate.sleep();//规定循环的延迟时间
		int i = 1;
		float delta;
		if(pose_x >50){//判断是否需要降落
		ROS_INFO("Start landing");//提示开始降落 
			delta = pose_z;//存储开始降落时候的高度 
			while(i<=5){
				ros::Duration(2).sleep();
				vel_z = -delta/5;
				ac_z = PIDCtrl_dir(angle_dir);
				cmd_vel_msg.angular.z = ac_z;
				vel_x = 0.03*(dis_max-4);
				cmd_vel_msg.linear.x = vel_x;
				i++;
				if(pose_z <= 0.5){
					break;
				}
				ros::spinOnce();
				loop_rate.sleep();
				}
			break;}
	    }
    return 0;
}

