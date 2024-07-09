%% 纯惯性导航程序
% 程序描述：导航坐标系为东-北-天；载体系为右-前-上；
% 0<航向角（yaw）<2*pi,北偏西为正；
% -pi/2<俯仰角（pitch）<pi/2;
% -pi<横滚角（roll）<pi;
%% 加载数据和采集信息
clc;close all;clear all;
format long g;   %长格式，显示15位
%load data;       %数据文件在程序目录文件中
load pdata;
dt=0.01;    %采样间隔
time=60*10;    %采样时间
N=time/dt;%数据长度
fxa = pdata(1:60000,4);% x轴加速度计均值；
fya = pdata(1:60000,5);% y轴加速度计均值；
fza = pdata(1:60000,6);% z轴加速度计均值；
gxa = pdata(1:60000,1);% x轴陀螺均值；
gya = pdata(1:60000,2);% y轴陀螺均值；
gza = pdata(1:60000,3);% z轴陀螺均值；
fibx_b = zeros(1,N);
fiby_b = zeros(1,N);
fibz_b = zeros(1,N);
Wibx_b = zeros(1,N);
Wiby_b = zeros(1,N);
Wibz_b = zeros(1,N);
for i = 1:N
    A = inv([-21.964409, -0.004296, 0.000547; 0.006081,  26.080312, 0.001835; -0.000983, 0.000269, 22.568396])*(transpose([fxa(i), fya(i), fza(i)])-transpose([0.175291, 0.134054, -0.146180]));
    B = inv([145067.968953, -0.003375, -0.000472; 0.004243, -143196.346624, -0.003810; -0.000889, -0.000968, -149870.468087])*(transpose([gxa(i), gya(i), gza(i)])-transpose([1.908403, -18.770341, -2.410120]));
    fibx_b(i) = A(1);
    fiby_b(i) = A(2);
    fibz_b(i) = A(3);
    Wibx_b(i) = B(1);
    Wiby_b(i) = B(2);
    Wibz_b(i) = B(3);
end
%fibx_b=f_INSc(1,:);              %加载X向比力信息fx
%fiby_b=f_INSc(2,:);              %加载Y向比力信息fy
%fibz_b=f_INSc(3,:);              %加载Z向比例信息fz
%Wibx_b=wib_INSc(1,:);          %加载陀螺仪X向角速率Wibx
%Wiby_b=wib_INSc(2,:);          %加载陀螺仪Y向角速率Wiby
%Wibz_b=wib_INSc(3,:);          %加载陀螺仪Z向角速率Wiby
t=dt:dt:time;
%****************************************************************
%% 给需要观察过程变化的变量分配存储空间
num=1;
test_vx=zeros(1,N);   %速度
test_vy=zeros(1,N);
test_vz=zeros(1,N);
test_longitude=zeros(1,N);  %经度
test_latitude=zeros(1,N);   %纬度
test_height=zeros(1,N);
test_yaw=zeros(1,N);   %航向角      
test_pitch=zeros(1,N); %俯仰角
test_roll=zeros(1,N); %横滚角
test_g=zeros(1,N);%重力加速度
%****************************************************************
%% 系统参量初始化
Wie=7.292115147e-5;   %地球自转角速度(d2r/s)
e=1/298.3;            %克拉索夫斯基椭球度
Re=6378245;           %克拉索夫斯基椭球长半径（m）
d2r=pi/180;            %弧度转换单位
near_zero=1e-19;
longitude=116.344695283*d2r;  %系统初始经度（单位/度）
latitude=39.981430925*d2r;     %系统初始纬度（单位/度）
height=70;                    %系统初始高度
Vx=0;     %系统初始东向速度 
Vy=0;        %系统初始北向速度 
Vz=0;        %系统初始天向速度
Wie_e=[0,0,Wie]';

% yaw=0*d2r;   %系统初始航向角
% pitch=0*d2r; %系统初始俯仰角
% roll=0*d2r;  %系统初始横滚角
% 
% %****************************************************************
% %% 根据初始姿态角，求出初始姿态阵和四元素初始值
% % 航向角北偏西为正，参考陈哲一书
% Cbn(1,1) =  cos(roll) * cos(yaw) - sin(roll) * sin(pitch) * sin(yaw);
% Cbn(1,2) = -cos(pitch) * sin(yaw);
% Cbn(1,3) =  sin(roll) * cos(yaw) + cos(roll) * sin(pitch) * sin(yaw);
% Cbn(2,1) =  cos(roll) * sin(yaw) + sin(roll) * sin(pitch) * cos(yaw);
% Cbn(2,2) =  cos(pitch) * cos(yaw);
% Cbn(2,3) =  sin(roll) * sin(yaw) - cos(roll) * sin(pitch) * cos(yaw);
% Cbn(3,1) = -sin(roll) * cos(pitch);
% Cbn(3,2) =  sin(pitch);
% Cbn(3,3) =  cos(roll) * cos(pitch);
%%%%**********粗对准计算方法，需要将静态时陀螺、加速度计的数据平均值填入******
fx0 = mean(pdata(1:60000,4));% x轴加速度计均值；
fy0 = mean(pdata(1:60000,5));% y轴加速度计均值；
fz0 = mean(pdata(1:60000,6));% z轴加速度计均值；
gx0 = mean(pdata(1:60000,1));% x轴陀螺均值；
gy0 = mean(pdata(1:60000,2));% y轴陀螺均值；
gz0 = mean(pdata(1:60000,3));% z轴陀螺均值；
gstd = 9.8016;%初始标准重力值；

Cbn(1, 1) = (-gz0 * fy0 + gy0 * fz0) / gstd / Wie / cos(latitude);
Cbn(2, 1) = -fx0 * tan(latitude) / gstd + gx0 / Wie / cos(latitude);
Cbn(3, 1) = fx0 / gstd;
Cbn(1, 2) = (-gx0 * fz0 + gz0 * fx0) / gstd / Wie / cos(latitude);
Cbn(2, 2) = -fy0 * tan(latitude) / gstd + gy0 / Wie / cos(latitude);
Cbn(3, 2) = fy0 / gstd;
Cbn(1, 3) = (-gy0 * fx0 + gx0 * fy0) / gstd / Wie / cos(latitude);
Cbn(2, 3) = -fz0 * tan(latitude) / gstd + gz0 / Wie / cos(latitude);
Cbn(3, 3) = fz0 / gstd;
%%%%%%%%%%%%%%%%%%%%%%
Cnb = inv(Cbn);
Q0=1+Cbn(1,1)+Cbn(2,2)+Cbn(3,3);
Q1=1+Cbn(1,1)-Cbn(2,2)-Cbn(3,3);
Q2=1-Cbn(1,1)+Cbn(2,2)-Cbn(3,3);
Q3=1-Cbn(1,1)-Cbn(2,2)+Cbn(3,3);
Q=[Q0;Q1;Q2;Q3];
Qmax=max(Q);
if(abs(Qmax-Q0)<near_zero) 
        QQ=[Q0;Cbn(3,2)-Cbn(2,3);Cbn(1,3)-Cbn(3,1);Cbn(2,1)-Cbn(1,2)];
    else
        if(abs(Qmax-Q1)<near_zero)
          QQ=[Cbn(3,2)-Cbn(2,3);Q1;Cbn(1,2)+Cbn(2,1);Cbn(1,3)+Cbn(3,1)];
        else
            if(abs(Qmax-Q2)<near_zero)
                QQ=[Cbn(1,3)-Cbn(3,1);Cbn(1,2)+Cbn(2,1);Q2;Cbn(2,3)+Cbn(3,2)];
            else
                QQ=[Cbn(2,1)-Cbn(1,2); Cbn(1,3)+Cbn(3,1); Cbn(2,3)+Cbn(3,2);Q3];
            end
        end
 end
 q=QQ/norm(QQ);
 q0=q(1);q1=q(2);q2=q(3); q3=q(4);
%****************************************************************
%% 根据初始位置，求出初始位置矩阵
% 选取指北方位，无游动方位角
Cen=[-sin(longitude),  cos(longitude),     0;
    -sin(latitude)*cos(longitude), -sin(latitude)*sin(longitude), cos(latitude);
    cos(latitude)*cos(longitude), cos(latitude)*sin(longitude), sin(latitude);];
Wie_n=Cen*Wie_e;
%****************************************************************
%% 根据初始位置矩阵，求出迭代计算需要的 地球速率 &位置速率
Ryn=Re/(1+2*e-3*e*sin(latitude)^2); %倒数
Rxn=Re/(1-e*sin(latitude)^2);       %倒数
Wen_n=[-Vy/(Ryn+height);Vx/(Rxn+height);Vx*tan(latitude)/(Rxn+height)]; %位移角速率初始值
g=9.7803+0.051799*sin(latitude)^2-0.94114*10^(-6)*height;
%****************************************************************
%% 引入外部阻尼的惯导高度通道
GPS_height=0;
lambda=0.01;
K1=3*lambda;
K2=4*lambda^2+2*g/Re;
K3=2*lambda^3;
bint = 0;
% alte1 = height - GPS_height;
% vdmp = K1 * alte1;
% admp = bint + K2 * alte1;
% bint = bint + K3 * alte1 * dt;
%****************************************************************
%% 进行迭代计算
for i=1:N
%%  求取姿态速率 
     Wib_b=[Wibx_b(i);Wiby_b(i);Wibz_b(i)]; %获取载体上陀螺仪测得的角速率
     Win_n=Wie_n+Wen_n;     %惯性坐标系相对导航坐标系在导航坐标系上的角速率
     Win_b=Cnb*Win_n;      %惯性坐标系相对导航坐标系在载体坐标系上的角速率
     Wnb_b=Wib_b-Win_b;     %得到初始姿态矩阵速率 
%%  比卡逼近法更新四元素q，求取姿态阵Cbn 
% 角增量法，可参考秦永元一书
   W=[     0,      -Wnb_b(1),  -Wnb_b(2),   -Wnb_b(3);
         Wnb_b(1),      0,        Wnb_b(3),  -Wnb_b(2);
         Wnb_b(2),   -Wnb_b(3),      0,      Wnb_b(1);
         Wnb_b(3),    Wnb_b(2),  -Wnb_b(1),     0     ];%
    dth=W*dt;                  %求解[△theta]
    dth2=dth(1,2)^2+dth(1,3)^2+dth(1,4)^2;
    q=((1-dth2/8)*eye(4)+(1/2-dth2/48)*dth)*q; %采用三阶算法
    q0=q(1);q1=q(2);q2=q(3);q3=q(4);
    qq=sqrt(q0^2+q1^2+q2^2+q3^2);    %归一化处理
    q0=q0/qq;q1=q1/qq;q2=q2/qq;q3=q3/qq;
    q=[q0;q1;q2;q3];
    Cbn=[q0^2+q1^2-q2^2-q3^2   2*(q1*q2-q0*q3)    2*(q1*q3+q0*q2);
        2*(q1*q2+q0*q3)    q0^2-q1^2+q2^2-q3^2    2*(q2*q3-q0*q1);
        2*(q1*q3-q0*q2)    2*(q2*q3+q0*q1)     q0^2-q1^2-q2^2+q3^2];
    Cnb=Cbn';
%% 速度更新
%   高度通道增加阻尼，参考AIAA一书
    fib_b=[fibx_b(i);fiby_b(i);fibz_b(i)];%获取载体上的比力信息
    fn=Cbn * fib_b;
    V=[Vx,Vy,Vz]';
    gn=[0;0;-g];
    alte1 = height - GPS_height;
    vdmp = K1 * alte1;
    admp = bint +K2 * alte1;% 
    bint = bint + K3 * alte1 * dt;
    Omiga_enn=[0,-Wen_n(3),Wen_n(2);Wen_n(3),0,-Wen_n(1);-Wen_n(2),Wen_n(1),0];
    Omiga_ien=[0,-Wie_n(3),Wie_n(2);Wie_n(3),0,-Wie_n(1);-Wie_n(2),Wie_n(1),0];
    Acc=fn-(Omiga_enn+2*Omiga_ien)*V+gn-[0,0,admp]';
    V=V+Acc*dt;    %更新速度
    Vx=V(1);Vy=V(2);Vz=V(3);
%%  位置更新 
%   位置更新，参考以光瞿一书，没有用到位置矩阵。
    longitude=longitude+Vx/(Rxn+height)*sec(latitude)*dt;
    latitude=latitude+Vy/(Ryn+height)*dt;
%   longitude=longitude+Vx/(Rxn+height)*sec(latitude)*dt;
    height=height+(Vz-vdmp)*dt;
    g=9.7803+0.051799*sin(latitude)^2-0.94114*10^(-6)*height;%重力加速度——更新（陈哲）
    Ryn=Re/(1+2*e-3*e*sin(latitude)^2);%子午面曲率半径倒数——更新
    Rxn=Re/(1-e*sin(latitude)^2);%卯酉圈曲率半径倒数——更新
    Wen_n=[-Vy/(Ryn+height);Vx/(Rxn+height);Vx*tan(latitude)/(Rxn+height)];% 地球角速率——更新
%****************************************************************
%%  根据更新的姿态矩阵，求解相关姿态角
%俯仰角，-pi/2<pitch<pi/2;
    if(abs(Cbn(3,2))<1-near_zero)
        fy=atan(Cbn(3,2)/sqrt(1-Cbn(3,2)*Cbn(3,2)));%实为asin（Cbn（3，2））
        pitch=fy;
    end
% 横滚角，-pi<roll<pi;参考陈哲
% Cbn(3,1) = -sin(roll) * cos(pitch);
% Cbn(3,3) =  cos(roll) * cos(pitch);
    if(abs(Cbn(3,3))>near_zero)
        hg=atan(-Cbn(3,1)/Cbn(3,3));
        if(Cbn(3,3)>0)
            roll=hg;
        else
            if(abs(Cbn(3,1))>near_zero)
                if(-Cbn(3,1)<0)
                   roll=hg-pi;
                else
                    roll=hg+pi;
                end
            else
                roll=0;
            end
        end
    else
        if(-Cbn(3,1) > 0)
            roll = pi / 2;
        else
            roll = -pi / 2;
        end
    end
% Cbn(1,2) = -cos(pitch) * sin(yaw);
% Cbn(2,2) =  cos(pitch) * cos(yaw);
   if(abs(Cbn(2,2))>near_zero)
       hx = atan(-Cbn(1,2)/Cbn(2,2));
       if(Cbn(2,2) > 0)
           if(abs(Cbn(1,2))>near_zero)
               if(-Cbn(1,2) > 0)
                   yaw = hx;
               else
                   yaw = hx + pi * 2;
               end
           else
               yaw = 0;
           end
       else
           yaw = hx + pi;
       end
   else
       if(-Cbn(1,2) > 0)
           yaw = pi/ 2;
       else
           yaw = 3 * pi / 2;
       end
   end
%****************************************************************
%% 给观察的变量赋值 
    test_vx(num)=Vx;   %速度
    test_vy(num)=Vy;
    test_vz(num)=Vz;
    test_longitude(num)=longitude-116.344695283*d2r;  %经度
    test_latitude(num)=latitude-39.981430925*d2r;   %纬度
    test_height(num)=height-0;
    test_yaw(num)=yaw;   %航向角      
    test_pitch(num)=pitch; %俯仰角
    test_roll(num)=roll; %横滚角
    num=num+1;
end
%% 画出系统各参数变化曲线
% %***********************画出速度曲线图*****************************
figure(1)
subplot(3,3,1),plot(t,test_vx);
title('东向速度变化图');
xlabel('时间(s)');ylabel('东向速度(m/s)');grid on;

subplot(3,3,2),plot(t,test_vy);
title('北向速度变化图');
xlabel('时间(s)');ylabel('北向速度(m/s)');grid on;

subplot(3,3,3),plot(t,test_vz);
title('天向速度变化图');
xlabel('时间(s)');ylabel('天向速度(m/s)');grid on;
% %************************画出位置曲线图******************************
subplot(3,3,4),plot(t,test_longitude./d2r);
title('经度(longitude)变化图');
xlabel('时间(s)');ylabel('经度(度)');grid on;

subplot(3,3,5),plot(t,test_latitude./d2r);
title('纬度(latitude)变化图');
xlabel('时间(s)');ylabel('纬度(度)');grid on;

subplot(3,3,6),plot(t,test_height);
title('高度变化图');
xlabel('时间(s)');ylabel('高度(m)');grid on;
% %****************************画出姿态曲线图*****************************

subplot(3,3,7),plot(t,test_yaw./d2r);
title('航向角(phi)变化图');
xlabel('时间(s)');ylabel('航向角(度)');grid on;

subplot(3,3,8),plot(t,test_pitch./d2r);
title('俯仰角(theta)变化图');
xlabel('时间(s)');ylabel('俯仰角(度)');grid on;

subplot(3,3,9),plot(t,test_roll./d2r);
title('横滚角(gamma)变化图');
xlabel('时间(s)');ylabel('横滚角(度)');grid on;
