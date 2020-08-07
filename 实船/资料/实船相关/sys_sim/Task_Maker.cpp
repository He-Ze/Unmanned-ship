#include <bits/stdc++.h>
#include <stdlib.h>
#include <ros/ros.h>
#include <algorithm>
#include <vector>
#include <geometry_msgs/Vector3.h>
#include <sys_sim/globalObstacle.h>
#include <sys_sim//targetPoint.h>
#include <sys_sim/usv.h>
using namespace std;

class Pathplan
{
public:
	Pathplan(){//构造函数
		position.push_back(0);
		position.push_back(0);
		nums=0;
		all=0;
		pub_next.push_back(0);
		pub_next.push_back(0);
		pub_next.push_back(0);
		had_got=false;
		has_plan=false;
		success=false;
		sub_usv = nh.subscribe("usv",1000,&Pathplan::set_the_boat,this);
		sub_globalObstacle = nh.subscribe("globalObstacle",1000,&Pathplan::add_ball,this);
        pub_targetPoint = nh.advertise <sys_sim::targetPoint>("targetPoint",1000);
        feed_back = nh.subscribe("target_feedback",1000,&Pathplan::get_feedback,this);
	}
	bool had_got_msg(){//用来确认控制层是不是接受到了规划的点
		return had_got;
	}
	void get_feedback(const sys_sim::targetPoint& msg){//这个函数用来接受控制层的反馈
			if (msg.x.size()==0) {cout<<"反馈信息为空"<<endl;return ;}//反馈信息为空就直接结束
			if (msg.z[0]==-2) {cout<<"所有目标点已经走完，现在开始随即发布目标点\n";pub_target_task2();return;}
			if (msg.z[0]==-1) {//标志位为-1，则设置had_got
							cout<<"确认控制层获得点信息"<<endl;
							had_got=true;
							
						}
						else if(msg.z[0]==1){//标志位不为-1，则将该点从yellow_ball中删除，并将path的最前面的点删除，保留在complished中
							for (int i=0;i<yellow_balls.size();i++){
								if (yellow_balls[i][0]==msg.x[0] && yellow_balls[i][1]==msg.y[0] && yellow_balls[i][2]!=1){
									cout<<"要删除的点为"<<yellow_balls[i][0]<<" "<<yellow_balls[i][1]<<endl;
									yellow_balls[i][2]=1;//设置为1表示下次不再考虑
									vector<double> temp;
									pub_next[0]=yellow_balls[i][0];
									pub_next[1]=yellow_balls[i][1];
									pub_next[2]=1;
									temp.push_back(yellow_balls[i][0]);
									temp.push_back(yellow_balls[i][1]);
									temp.push_back(1);
									complished.push_back(temp);
									vector<int>::iterator tempx=path.begin();
									path.erase(tempx);
									nums++;//救援点的数量+1
									cout<<"点已经从当前规划路径中删除，下次发布将不存在，"<<"默认船已经救援数量"<<complished.size()<<endl;
								}
							}
						
						}
						else if (msg.z[0]==2){
							pub_next[0]=msg.x[0];
							pub_next[1]=msg.y[0];
							pub_next[2]=2;
						}
					
		
	}	
	void set_the_boat(const sys_sim::usv& msg)//获取船的位置信息
	{

			position[0]=msg.x;
			position[1]=msg.y;
			cout<<"船位置信息："<<position[0]<<" "<<position[1]<<endl;
	}

	void add_ball(const sys_sim::globalObstacle& msg)//获取球的信息并在出现新黄球的时候规划
	{
		if (msg.x.size()>all)
		{
			bool is_plan=false;
			for (int i=all;i<msg.x.size();i++)
			{
				all++;
				if (msg.color[i]==4)
				{
					vector<double> temp;
					temp.push_back(msg.x[i]);
					temp.push_back(msg.y[i]);
					temp.push_back(0);
					is_plan=true;
					yellow_balls.push_back(temp);
				}
			}
			has_plan=path_plan(is_plan);
			if (is_plan==true) {had_got=false;cout<<"路径规划成功"<<endl;}//设置had_got为假，则下次需要发布时会允许发布
		}
		
	}
	void get_the_matrix(vector<vector<double>>& matrix){//这个是模拟退火算法计算路径的一部分
		vector<vector<double>> temp;
		temp.push_back(position);
		if (find_order.size()!=0) find_order.clear();
		for (int i=0;i<yellow_balls.size();i++){
			if (yellow_balls[i][2]==0) {
				find_order.push_back(i);
				temp.push_back(yellow_balls[i]);
			}

		}
		for (int i=0;i<temp.size();i++){
			vector<double> x(temp.size());
			matrix.push_back(x);
		}
		for (int i=0;i<temp.size();i++){
			for (int j=0;j<temp.size();j++){
				if (i!=j)matrix[i][j]=sqrt(pow(temp[i][0]-temp[j][0],2)+pow(temp[i][1]-temp[j][1],2));
				else matrix[i][j]=0;
			}
		}
		for (int i=0;i<matrix.size();i++){
			for (int j=0;j<matrix[i].size();j++){
				cout<<matrix[i][j]<<" ";
			}
			cout<<endl;
		}
	}
	void change(vector<int>&v){//这个是模拟退火算法计算路径的一部分
		
    	int x = rand()%v.size();
    	int y = rand()%v.size();
    	while(y == x) y = rand()%v.size();
    	for(int i=0; i+x<=(x+y>>1); ++i)
        	if (x+i!=0 && y-i!=0) swap(v[i+x], v[y-i]);
       
	}
	double all_dis(vector<int>& patha,const vector<vector<double>>& matrix){
		
		double all_distance=0;
		for (int i=0;i<patha.size()-1;i++){
			all_distance+=matrix[patha[i]][patha[i+1]];
		}
		
		return all_distance;
	}
	void tuihuo(const vector<vector<double>>& matrix){//模拟退火算法得到一条路径的序号
		double T0=matrix.size()*10;
		double T1=1e-9;
		double r=0.99;
		int len=100;
		vector<int> paths;
		for (int i=0;i<matrix.size();i++){
			paths.push_back(i);
		}
		srand((unsigned int)time(NULL));

		while (T0>T1)
		{
			for (int i=0;i<len;i++)
			{
				vector<int>temp=paths;
				change(temp);
				double pre=all_dis(paths,matrix);
				double cur=all_dis(temp,matrix);
				if(cur<pre||exp(-(cur-pre)/T0)>((double)rand())/RAND_MAX){
					paths=temp;
				}
				
			}
			T0*=r;
		}
		vector<int>::iterator tempx=paths.begin();
		cout<<"路径序号为：";
		for (int i=0;i<paths.size();i++){
			cout<<paths[i]<<" ";
		}
		cout<<endl;
		cout<<"规划的最短路径为："<<all_dis(paths,matrix)<<endl;
		paths.erase(tempx);
		path=paths;
	
	}
	bool path_plan(bool is_plan)//规划函数
	{

		if (is_plan==false) return false;
		else 
		{

			vector<vector<double>> matrix;
			get_the_matrix(matrix);
			tuihuo(matrix);
			return true;
		}
	}
	
	
	void pub_target_task2() //发布函数
	{
		
		target_point.x.clear();
		target_point.y.clear();
		target_point.z.clear();
		if (nums==15) {success=true;cout<<"任务完成"<<endl;return ;}//如果够15个点就直接判断任务完成，结束即可
		if (has_plan==false) {//最开始每收到点没规划的时候的情况
			target_point.x.push_back(50);
			target_point.y.push_back(50);
			target_point.z.push_back(0);
			pub_targetPoint.publish(target_point);
			cout<<"路径为规划，临时目标：";
		for (int i=0;i<target_point.x.size();i++){
			cout<<target_point.x[i]<<" "<<target_point.y[i]<<" "<<target_point.z[i]<<endl;
			return ;
		}
		}
		else {
			if (path.size()==0) {//所有收到了信息的点都走完了的情况
				srand((unsigned int)NULL);
				vector<int> ret;
				get_the_max(ret);
				if (pub_next[2]==1) {
					target_point.x.push_back(pub_next[0]);
					target_point.y.push_back(pub_next[1]);
					target_point.z.push_back(1);
					cout<<"上次未完成但目标已经加入（随机路径），";
					cout<<"要加入的点为"<<pub_next[0]<<" "<<pub_next[1]<<endl;
				}

				target_point.x.push_back(rand()%(ret[1]+1));
				target_point.y.push_back(rand()%(ret[3]+1));
				target_point.z.push_back(0);
				pub_targetPoint.publish(target_point);
				cout<<"目标点为："<<endl;
				cout<<"一共"<<target_point.x.size()<<"个点："<<endl;
				for (int i=0;i<target_point.x.size();i++){
					cout<<target_point.x[i]<<" "<<target_point.y[i]<<" "<<target_point.z[i]<<endl;
				}	
					return ;
				}
			else {//规划的点没走完的情况
				
				if (pub_next[2]==1) {
					target_point.x.push_back(pub_next[0]);
					target_point.y.push_back(pub_next[1]);
					target_point.z.push_back(1);
					cout<<"上次未完成但目标已经加入（规划路径），";
					cout<<"要加入的点为"<<pub_next[0]<<" "<<pub_next[1]<<endl;
				}
				for (int i=0;i<path.size();i++){
					target_point.x.push_back(yellow_balls[find_order[path[i]-1]][0]);
					target_point.y.push_back(yellow_balls[find_order[path[i]-1]][1]);
					target_point.z.push_back(2);
				}
				pub_targetPoint.publish(target_point);
				cout<<"目标点为："<<endl;
				cout<<"一共"<<target_point.x.size()<<"个点："<<endl;
		for (int i=0;i<target_point.x.size();i++){
			cout<<target_point.x[i]<<" "<<target_point.y[i]<<" "<<target_point.z[i]<<endl;
		}
				return ;
			}
			
		}
		
		return ;

	}
	
	void get_the_max(vector<int>& ret){//这个是产生随即点函数的一部分
	
		if (complished.size()==0) {
			ret.push_back((int)position[0]),ret.push_back((int)yellow_balls[0][0]),ret.push_back((int)position[1]),ret.push_back((int)yellow_balls[0][1]);
		}
		else {
			int xmax=0,ymax=0;
			int xmin=INT_MAX,ymin=xmin;
			for (int i=0;i<complished.size();i++){
					if (xmin>(int)complished[i][0]) xmin=(int)complished[i][0];
					if (ymin>(int)complished[i][1]) ymin=(int)complished[i][1];
					if (xmax<(int)complished[i][0]) xmax=(int)complished[i][0];
					if (ymax<(int)complished[i][1]) ymax=(int)complished[i][1];
					
				}
				
			ret.push_back(xmin),ret.push_back(xmax),ret.push_back(ymin),ret.push_back(ymax);
			}

			
	}
	
	~Pathplan()
	{
		yellow_balls.clear();
		white_balls.clear();
		position.clear();
		complished.clear();
		path.clear();
		nums=0;
	}
	
	bool sucess_to_destination(){
		return success;
	}

private:
	ros::NodeHandle nh;//节点
    ros::Publisher pub_targetPoint;//这是发布目标点信息的
    ros::Subscriber sub_globalObstacle;//订阅了障碍球的信息
    ros::Subscriber sub_usv;//订阅船的信息
    ros::Subscriber feed_back;//订阅控制层发布的信息
    sys_sim::targetPoint target_point;//发布目标点的信息：x,y和软硬信息
	vector<vector<double>> yellow_balls;//需要营救的人质:x,y
	vector<vector<double>> white_balls;//需要避开的障碍物
	vector<vector<double>> complished;
	vector<int> path;//辅助查找最短路径的向量数组
	vector<double> position;//船现在的位置
	vector<int> find_order;
	vector<double> pub_next;
	bool success;//判断最后是不是所有球体已经救援完成
	bool has_plan;
	bool had_got;
	int nums;//已经救援的球体
	int all;//所有已经获取信息的球体
};

int main(int argc,char ** argv){
	ros::init(argc,argv,"Pathplan");
	Pathplan plan;

	ros::Rate loop_rate(1);//f为发布频率（相对于sys_sim.cpp提高了一倍的频率） 
	while(ros::ok() && !plan.sucess_to_destination())//到终点就不发布信息了
    {
        if (!plan.had_got_msg())plan.pub_target_task2();//发布目标
        ros::spinOnce();
        loop_rate.sleep();//睡眠相应时间
    } 
}
