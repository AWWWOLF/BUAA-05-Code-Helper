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

float angle_min = -2.3561899662; //���״����ݵ���ʼ�Ƕȣ���С�Ƕȣ�
float angle_max = 2.3561899662;//���״����ݵ���ֹ�Ƕȣ����Ƕȣ�
float angle_increment = 0.00436331471428;  //���״����ݵĽǶȷֱ��ʣ��Ƕ�������

//�洢��̬�Լ�λ�� 
float pose_x = 0;
float pose_y = 0;
float pose_z = 0;
float vector_x = 0; 
float vector_y = 0;
float vector_z = 0;


//�������Ƹ߶� 
float pose_z_h = 2;

//��ʼ��������̬�Ĳ��� 
float vel_z = 0; //�ٶ�
float vel_x = 0; //�ٶ�  ///  ���� 
float ac_z = 0.2; 
float angle_dir = 0; //��ʼ�����庽�������� 
float dis_max = 0;
int ranges_size = 0;
int index_max = 0;

// �ص���������ȡ����ɨ�����ݣ��ҳ����е�������ֵ�����ݴ˼������˻��ĺ�������ֵ��
void scanCallback(const sensor_msgs::LaserScan::ConstPtr& msg){
    ranges_size = (780>msg->ranges.size())? msg->ranges.size(): 780;
	//��δ���������ǽ�ranges_size����Ϊmsg->ranges.size()��780�н�С���Ǹ�ֵ��
	//float32[] ranges���״�����ÿ�����Ӧ���ڼ�����ϵ�µľ���ֵ [m]
    dis_max = 0;//dis_maxΪ�������ֵ 
    int i = 0;
    for (; i< ranges_size; ++i){
        if(isinf(msg->ranges[i]) == 0){
          if(msg->ranges[i]> dis_max){
              dis_max = msg->ranges[i];
              index_max = i;//ѡ�����ֵ�Լ����ֵ��Ӧ��λ�� 
          }
        }
    }
    angle_dir = angle_min + angle_increment * index_max;//�����0�����ĺ���ֵ
}

//ROS�����ڴ��������λ�ˣ�λ�ú���̬����Ϣ�Ļص�����
//��ȡ��x��y��z����ֵ���ֱ�洢��ȫ�ֱ���pose_x��pose_y��pose_z
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

//���������߶Ⱥ�ʵ�ʸ߶Ƚ��и߶ȿ��ƣ������߽� 
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

//�������ǽ��к�����ƣ�dirΪ����ϵ�½Ƕȣ���ͷ����нǣ�����������0 
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
    ros::init(argc,argv,"hector_ctrl_node");//��ʼ���ڵ� 
    ros::NodeHandle nh;//�����ڵ���������ڵ����Դ��ָ��ȫ�ֿռ� 
    ros::Publisher velocity_publisher_;//��������ͨѶ���� 
    ros::ServiceClient motor_enable_service_;//����һ������ͨѶ 
    ros::Rate loop_rate(10); //����ѭ����Ƶ����10hz
    ros::Publisher cmd_vel_pub = nh.advertise<geometry_msgs::Twist>("/cmd_vel",1000);
	//����һ��Publisher��������Ϊ/cmd_vel��topic����Ϣ����Ϊgeometry_msgs::Twist�����г���1000 
    motor_enable_service_ = nh.serviceClient<hector_uav_msgs::EnableMotors>("enable_motors");
    if(!motor_enable_service_.waitForExistence(ros::Duration(5.0))){
        ROS_WARN("motor enable service not found");
        return false;
    }
    /*ͬ�ϣ��������serves�����Ʋ��ҹ涨��Ϣ���ͣ�
	����Serviceͨ�ŵ������ԣ���һ��client.waitForExistence()��������ʽ�������Ա�֤�����͵��õ�˳��*/ 
    ros::Subscriber subScan = nh.subscribe("/scan",50, scanCallback); //0.25s�ĸ���Ƶ��
    ros::Subscriber subPose = nh.subscribe("/ground_truth_to_tf/pose",50, PoseCallback); //0.25s �ĸ���Ƶ��
    ros::Subscriber subVector3 = nh.subscribe("/ground_truth_to_tf/euler",50, VectorCallback); ///
    // ���� /scan�� /ground_truth_to_tf/pose�������� 
    hector_uav_msgs::EnableMotors srv;
    srv.request.enable = true;//����hector_uav_msgs��Ϣ�������溬��һЩsenor_msg����û�е���Ϣ 
    motor_enable_service_.call(srv);//��srv����������ķ���ͨѶ�� 
    while(ros::ok()){//ȷ��״̬��������ctr+C���߱��һЩ�쳣���ʱ����ֵ�ſ�����FALSE
    	ros::Duration(2).sleep();//�ȴ����������˻����� 
        geometry_msgs::Twist cmd_vel_msg;//ʹ��Twist���͵��������������˻����˶� 
        vel_z = PIDCtrl_height(pose_z, pose_z_h);//ʹ���˻�������2m�߶� 
        vel_x = 0.07*(dis_max-3.7);//ʹ���˻�ǰ��һ�ξ����ͬʱ��ײ���ϰ��� 
        ac_z = PIDCtrl_dir(angle_dir);
        cmd_vel_msg.linear.z = vel_z;
		cmd_vel_msg.angular.z = ac_z;
        cmd_vel_msg.linear.x = vel_x;
        //�ø��µ�λ�á��ǶȵȲ����ı仯ʹ���˻��˶�
		//�������˻��ȶ� 
        ROS_INFO("vel z is %f, vel x is %f, angular z is %f\n", vel_z, vel_x, ac_z);//������Ƶ�������Ϣ
        cmd_vel_pub.publish(cmd_vel_msg);//����
        ros::spinOnce();//�����ݴ���ص�����ѭ�� 
        loop_rate.sleep();//�涨ѭ�����ӳ�ʱ��
		int i = 1;
		float delta;
		if(pose_x >50){//�ж��Ƿ���Ҫ����
		ROS_INFO("Start landing");//��ʾ��ʼ���� 
			delta = pose_z;//�洢��ʼ����ʱ��ĸ߶� 
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

