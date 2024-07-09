clc;
clear;
%% 质量外形参数
m=3629; 
Ix=4753;Iy=17306.8;Iz=21256.2;Ixz=-509.6;Izx=Ixz;
fai_t=0;s=17.02;c=1.8494;b=9.63;

%% 初始飞行状态参数
Cl=0.2714;
Cd=0.028;
Cm=0;
T=3721;
V=131.6;
alpha=deg2rad(3);
rou=0.9091;

%% 部分气动导数和操纵导数
Cla=4.817;Cda=0.19;Cma=0.24;
Clv=0;Cdv=0;Cmv=0;
Cla1=0;Cma1=-2.153;
Clq=2.1;Cmq=-6.11;
Cldeltae=0.3942;Cddeltae=0;Cmdeltae=-0.9054;
Tdeltap=3033;Cmdeltap=0;deltaM_deltap=0;
Cybeita=-0.8628;Clbeita=-0.07752;Cnbeita=0.1218;
Cyp=0;Clp=-0.4165;Cnp=0.01038;
Cyr=0;Clr=0.1539;Cnr=-0.2004;
Cydeltaa=0;Cldeltaa=-0.2165;Cndeltaa=-0.0051;
Cydeltar=0.2694;Cldeltar=0.03104;Cndeltar=-0.1039;
g=9.8;Tv=0;fai=0;

%% 纵向气动导数计算
q=1/2*rou*V*V;
Xv = Tv*cos(alpha+fai_t)/m-(Cdv+2*Cd)*q*s/m/V;
Xdeltae = -Cddeltae*q*s/m;
Zv = Tv*sin(alpha+fai)/m/V+(Clv+2*Cl)*q*s/m/V/V;
Za = (T*cos(alpha+fai_t)+Cla*q*s)/m/V;
Zq=Clq*(c/2/V)*q*s/m/V;
Zdeltae=Cldeltae*q*s/m/V;
Mv=Cmv*q*s*c/V/Iy;
Mq=Cmq*(c/2/V)*q*s*c/Iy;
Mdeltae=Cmdeltae*q*s*c/Iy;
Xa=-T*sin(alpha+fai_t)/m-Cda*q*s/m;
Xdeltap=Tdeltap*cos(alpha+fai_t)/m;
Za1=Cla1*(c/2/V)*q*s/m/V;
Zdeltap=Tdeltap*sin(alpha+fai)/m/V;
Ma=Cma*q*s*c/Iy;
Ma1=Cma1*(c/2/V)*q*s*c/Iy;
Mdeltap=(Cmdeltap*q*s*c+deltaM_deltap)/Iy;

%% 横航向气动导数
Ybeita=Cybeita*q*s/m/V;
Yp=Cyp*q*s*b/m/V/2/V;
Yr=Cyr*q*s*b/m/V/2/V;
Ydeltaa=Cydeltaa*q*s/m/V;
Ydeltar=Cydeltar*q*s/m/V;
Nbeita=Cnbeita*q*s*b;
Np=Cnp*q*s*b*b/2/V;
Nr=Cnr*q*s*b*b/2/V;
Ndeltaa=Cndeltaa*q*s*b;
Ndeltar=Cndeltar*q*s*b;
Lbeita=Clbeita*q*s*b;
Lp=Clp*q*s*b*b/2/V;
Lr=Clr*q*s*b*b/2/V;
Ldeltaa=Cldeltaa*q*s*b;
Ldeltar=Cldeltar*q*s*b;
Lbeita1=(Lbeita+(Izx/Iz)*Nbeita)/(Ix-Izx*Izx/Iz);
Lp1=(Lp+(Izx/Iz)*Np)/(Ix-Izx*Izx/Iz);
Lr1=(Lr+(Izx/Iz)*Nr)/(Ix-Izx*Izx/Iz);
Ldeltaa1=(Ldeltaa+(Izx/Iz)*Ndeltaa)/(Ix-Izx*Izx/Iz);
Ldeltar1=(Ldeltar+(Izx/Iz)*Ndeltar)/(Ix-Izx*Izx/Iz);
Nbeita1=(Nbeita+(Izx/Ix)*Lbeita)/(Iz-Izx*Izx/Ix);
Np1=(Np+(Izx/Ix)*Lp)/(Iz-Izx*Izx/Ix);
Nr1=(Nr+(Izx/Ix)*Lr)/(Iz-Izx*Izx/Ix);
Ndeltaa1=(Ndeltaa+(Izx/Ix)*Ldeltaa)/(Iz-Izx*Izx/Ix);
Ndeltar1=(Ndeltar+(Izx/Ix)*Ldeltar)/(Iz-Izx*Izx/Ix);

%% 纵向方程、横航向方程
A_LON=[Xv Xa+g 0 -g;-Zv -Za 1 0;Mv-Ma1*Zv Ma-Ma1*Za Mq+Ma1 0;0 0 1 0];
B_LON=[Xdeltae Xdeltap;-Zdeltae -Zdeltap;Mdeltae-Ma1*Zdeltae Mdeltap-Ma1*Zdeltap;0 0];
A_LAT=[Ybeita alpha+Yp Yr-1 g*cos(alpha)/V;Lbeita1 Lp1 Lr1 0;Nbeita1 Np1 Nr1 0;0 1 tan(alpha) 0];
B_LAT=[0 Ydeltar;Ldeltaa1 Ldeltar1;Ndeltaa1 Ndeltar1;0 0];

%% 基本模态参数理论计算
% 特征根
[V_LON,D_LON]=eig(A_LON);
[V_LAT,D_LAT]=eig(A_LAT);
% 半衰期
t_h_LON=-log(2)./real(D_LON);
t_h_LAT=-log(2)./real(D_LAT);
% 振荡频率
omega_LON=abs(imag(D_LON));
omega_LAT=abs(imag(D_LAT));
% 周期
T_LON=2*pi./omega_LON;
T_LAT=2*pi./omega_LAT;
% 半衰期内振荡次数
N_h_LON=t_h_LON./T_LON;
N_h_LAT=t_h_LAT./T_LAT;

%% 安岗图绘制
Z1=compass(V_LON(:,1));
title('短周期模态');
Z1(1).Color='r';
Z1(2).Color='m';
Z1(3).Color='g';
Z1(4).Color='b';
legend('\Delta V','\Delta \alpha','\Delta q','\Delta \theta');

figure(2)
Z2=compass(V_LON(:,3));
title('长周期模态');
Z2(1).Color='r';
Z2(2).Color='m';
Z2(3).Color='g';
Z2(4).Color='b';
legend('\Delta V','\Delta \alpha','\Delta q','\Delta \theta');

figure(3)
Z3=compass(V_LAT(:,1));
title('滚转');
Z3(1).Color='r';
Z3(2).Color='m';
Z3(3).Color='g';
Z3(4).Color='b';
legend('\Delta \beta','\Delta p','\Delta r','\Delta \Phi');

figure(4)
Z4=compass(V_LAT(:,2));
title('荷兰滚模态');
Z4(1).Color='r';
Z4(2).Color='m';
Z4(3).Color='g';
Z4(4).Color='b';
legend('\Delta \beta','\Delta p','\Delta r','\Delta \Phi');

figure(5)
Z5=compass(V_LAT(:,4));
title('螺旋模态');
Z5(1).Color='r';
Z5(2).Color='m';
Z5(3).Color='g';
Z5(4).Color='b';
legend('\Delta \beta','\Delta p','\Delta r','\Delta \Phi');

%% 搭建线性模型
C=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
D=zeros(4,2);
t_step=0.01;
ini_state_LON = zeros(4,1);

%% 画图
simout = sim( 'zengwen.slx');
figure(6);
subplot(2,2,1)
plot(time(:,1),data_LON(:,1),'k');
title('V');
xlabel('t(s)');
ylabel('V(m/s)');
grid on;
subplot(2,2,2)
plot(time(:,1),data_LON(:,2),'k');
title('alpha');
xlabel('t(s)');
ylabel('alpha(rad)');
grid on;
subplot(2,2,3)
plot(time(:,1),data_LON(:,3),'k');
title('q');
xlabel('t(s)');
ylabel('q(rad/s)');
grid on;
subplot(2,2,4)
plot(time(:,1),data_LON(:,4),'k');
title('theta');
xlabel('t(s)');
ylabel('theta(rad)');
grid on;
figure(7);
subplot(2,2,1)
plot(time(:,1),data_LAT(:,1),'k');
title('beta');
xlabel('t(s)');
ylabel('beta(rad)');
grid on;
subplot(2,2,2)
plot(time(:,1),data_LAT(:,2),'k');
title('r');
xlabel('t(s)');
ylabel('r(rad/s)');
grid on;
subplot(2,2,3)
plot(time(:,1),data_LAT(:,3),'k');
title('p');
xlabel('t(s)');
ylabel('p(rad/s)');
grid on;
subplot(2,2,4)
plot(time(:,1),data_LAT(:,4),'k');
title('phi');
xlabel('t(s)');
ylabel('phi(rad)');
grid on;