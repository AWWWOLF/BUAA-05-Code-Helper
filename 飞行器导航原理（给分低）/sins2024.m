%% �����Ե�������
% ������������������ϵΪ��-��-�죻����ϵΪ��-ǰ-�ϣ�
% 0<����ǣ�yaw��<2*pi,��ƫ��Ϊ����
% -pi/2<�����ǣ�pitch��<pi/2;
% -pi<����ǣ�roll��<pi;
%% �������ݺͲɼ���Ϣ
clc;close all;clear all;
format long g;   %����ʽ����ʾ15λ
%load data;       %�����ļ��ڳ���Ŀ¼�ļ���
load pdata;
dt=0.01;    %�������
time=60*10;    %����ʱ��
N=time/dt;%���ݳ���
fxa = pdata(1:60000,4);% x����ٶȼƾ�ֵ��
fya = pdata(1:60000,5);% y����ٶȼƾ�ֵ��
fza = pdata(1:60000,6);% z����ٶȼƾ�ֵ��
gxa = pdata(1:60000,1);% x�����ݾ�ֵ��
gya = pdata(1:60000,2);% y�����ݾ�ֵ��
gza = pdata(1:60000,3);% z�����ݾ�ֵ��
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
%fibx_b=f_INSc(1,:);              %����X�������Ϣfx
%fiby_b=f_INSc(2,:);              %����Y�������Ϣfy
%fibz_b=f_INSc(3,:);              %����Z�������Ϣfz
%Wibx_b=wib_INSc(1,:);          %����������X�������Wibx
%Wiby_b=wib_INSc(2,:);          %����������Y�������Wiby
%Wibz_b=wib_INSc(3,:);          %����������Z�������Wiby
t=dt:dt:time;
%****************************************************************
%% ����Ҫ�۲���̱仯�ı�������洢�ռ�
num=1;
test_vx=zeros(1,N);   %�ٶ�
test_vy=zeros(1,N);
test_vz=zeros(1,N);
test_longitude=zeros(1,N);  %����
test_latitude=zeros(1,N);   %γ��
test_height=zeros(1,N);
test_yaw=zeros(1,N);   %�����      
test_pitch=zeros(1,N); %������
test_roll=zeros(1,N); %�����
test_g=zeros(1,N);%�������ٶ�
%****************************************************************
%% ϵͳ������ʼ��
Wie=7.292115147e-5;   %������ת���ٶ�(d2r/s)
e=1/298.3;            %��������˹�������
Re=6378245;           %��������˹�����򳤰뾶��m��
d2r=pi/180;            %����ת����λ
near_zero=1e-19;
longitude=116.344695283*d2r;  %ϵͳ��ʼ���ȣ���λ/�ȣ�
latitude=39.981430925*d2r;     %ϵͳ��ʼγ�ȣ���λ/�ȣ�
height=70;                    %ϵͳ��ʼ�߶�
Vx=0;     %ϵͳ��ʼ�����ٶ� 
Vy=0;        %ϵͳ��ʼ�����ٶ� 
Vz=0;        %ϵͳ��ʼ�����ٶ�
Wie_e=[0,0,Wie]';

% yaw=0*d2r;   %ϵͳ��ʼ�����
% pitch=0*d2r; %ϵͳ��ʼ������
% roll=0*d2r;  %ϵͳ��ʼ�����
% 
% %****************************************************************
% %% ���ݳ�ʼ��̬�ǣ������ʼ��̬�����Ԫ�س�ʼֵ
% % ����Ǳ�ƫ��Ϊ�����ο�����һ��
% Cbn(1,1) =  cos(roll) * cos(yaw) - sin(roll) * sin(pitch) * sin(yaw);
% Cbn(1,2) = -cos(pitch) * sin(yaw);
% Cbn(1,3) =  sin(roll) * cos(yaw) + cos(roll) * sin(pitch) * sin(yaw);
% Cbn(2,1) =  cos(roll) * sin(yaw) + sin(roll) * sin(pitch) * cos(yaw);
% Cbn(2,2) =  cos(pitch) * cos(yaw);
% Cbn(2,3) =  sin(roll) * sin(yaw) - cos(roll) * sin(pitch) * cos(yaw);
% Cbn(3,1) = -sin(roll) * cos(pitch);
% Cbn(3,2) =  sin(pitch);
% Cbn(3,3) =  cos(roll) * cos(pitch);
%%%%**********�ֶ�׼���㷽������Ҫ����̬ʱ���ݡ����ٶȼƵ�����ƽ��ֵ����******
fx0 = mean(pdata(1:60000,4));% x����ٶȼƾ�ֵ��
fy0 = mean(pdata(1:60000,5));% y����ٶȼƾ�ֵ��
fz0 = mean(pdata(1:60000,6));% z����ٶȼƾ�ֵ��
gx0 = mean(pdata(1:60000,1));% x�����ݾ�ֵ��
gy0 = mean(pdata(1:60000,2));% y�����ݾ�ֵ��
gz0 = mean(pdata(1:60000,3));% z�����ݾ�ֵ��
gstd = 9.8016;%��ʼ��׼����ֵ��

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
%% ���ݳ�ʼλ�ã������ʼλ�þ���
% ѡȡָ����λ�����ζ���λ��
Cen=[-sin(longitude),  cos(longitude),     0;
    -sin(latitude)*cos(longitude), -sin(latitude)*sin(longitude), cos(latitude);
    cos(latitude)*cos(longitude), cos(latitude)*sin(longitude), sin(latitude);];
Wie_n=Cen*Wie_e;
%****************************************************************
%% ���ݳ�ʼλ�þ����������������Ҫ�� �������� &λ������
Ryn=Re/(1+2*e-3*e*sin(latitude)^2); %����
Rxn=Re/(1-e*sin(latitude)^2);       %����
Wen_n=[-Vy/(Ryn+height);Vx/(Rxn+height);Vx*tan(latitude)/(Rxn+height)]; %λ�ƽ����ʳ�ʼֵ
g=9.7803+0.051799*sin(latitude)^2-0.94114*10^(-6)*height;
%****************************************************************
%% �����ⲿ����Ĺߵ��߶�ͨ��
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
%% ���е�������
for i=1:N
%%  ��ȡ��̬���� 
     Wib_b=[Wibx_b(i);Wiby_b(i);Wibz_b(i)]; %��ȡ�����������ǲ�õĽ�����
     Win_n=Wie_n+Wen_n;     %��������ϵ��Ե�������ϵ�ڵ�������ϵ�ϵĽ�����
     Win_b=Cnb*Win_n;      %��������ϵ��Ե�������ϵ����������ϵ�ϵĽ�����
     Wnb_b=Wib_b-Win_b;     %�õ���ʼ��̬�������� 
%%  �ȿ��ƽ���������Ԫ��q����ȡ��̬��Cbn 
% �����������ɲο�����Ԫһ��
   W=[     0,      -Wnb_b(1),  -Wnb_b(2),   -Wnb_b(3);
         Wnb_b(1),      0,        Wnb_b(3),  -Wnb_b(2);
         Wnb_b(2),   -Wnb_b(3),      0,      Wnb_b(1);
         Wnb_b(3),    Wnb_b(2),  -Wnb_b(1),     0     ];%
    dth=W*dt;                  %���[��theta]
    dth2=dth(1,2)^2+dth(1,3)^2+dth(1,4)^2;
    q=((1-dth2/8)*eye(4)+(1/2-dth2/48)*dth)*q; %���������㷨
    q0=q(1);q1=q(2);q2=q(3);q3=q(4);
    qq=sqrt(q0^2+q1^2+q2^2+q3^2);    %��һ������
    q0=q0/qq;q1=q1/qq;q2=q2/qq;q3=q3/qq;
    q=[q0;q1;q2;q3];
    Cbn=[q0^2+q1^2-q2^2-q3^2   2*(q1*q2-q0*q3)    2*(q1*q3+q0*q2);
        2*(q1*q2+q0*q3)    q0^2-q1^2+q2^2-q3^2    2*(q2*q3-q0*q1);
        2*(q1*q3-q0*q2)    2*(q2*q3+q0*q1)     q0^2-q1^2-q2^2+q3^2];
    Cnb=Cbn';
%% �ٶȸ���
%   �߶�ͨ���������ᣬ�ο�AIAAһ��
    fib_b=[fibx_b(i);fiby_b(i);fibz_b(i)];%��ȡ�����ϵı�����Ϣ
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
    V=V+Acc*dt;    %�����ٶ�
    Vx=V(1);Vy=V(2);Vz=V(3);
%%  λ�ø��� 
%   λ�ø��£��ο��Թ���һ�飬û���õ�λ�þ���
    longitude=longitude+Vx/(Rxn+height)*sec(latitude)*dt;
    latitude=latitude+Vy/(Ryn+height)*dt;
%   longitude=longitude+Vx/(Rxn+height)*sec(latitude)*dt;
    height=height+(Vz-vdmp)*dt;
    g=9.7803+0.051799*sin(latitude)^2-0.94114*10^(-6)*height;%�������ٶȡ������£����ܣ�
    Ryn=Re/(1+2*e-3*e*sin(latitude)^2);%���������ʰ뾶������������
    Rxn=Re/(1-e*sin(latitude)^2);%î��Ȧ���ʰ뾶������������
    Wen_n=[-Vy/(Ryn+height);Vx/(Rxn+height);Vx*tan(latitude)/(Rxn+height)];% ��������ʡ�������
%****************************************************************
%%  ���ݸ��µ���̬������������̬��
%�����ǣ�-pi/2<pitch<pi/2;
    if(abs(Cbn(3,2))<1-near_zero)
        fy=atan(Cbn(3,2)/sqrt(1-Cbn(3,2)*Cbn(3,2)));%ʵΪasin��Cbn��3��2����
        pitch=fy;
    end
% ����ǣ�-pi<roll<pi;�ο�����
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
%% ���۲�ı�����ֵ 
    test_vx(num)=Vx;   %�ٶ�
    test_vy(num)=Vy;
    test_vz(num)=Vz;
    test_longitude(num)=longitude-116.344695283*d2r;  %����
    test_latitude(num)=latitude-39.981430925*d2r;   %γ��
    test_height(num)=height-0;
    test_yaw(num)=yaw;   %�����      
    test_pitch(num)=pitch; %������
    test_roll(num)=roll; %�����
    num=num+1;
end
%% ����ϵͳ�������仯����
% %***********************�����ٶ�����ͼ*****************************
figure(1)
subplot(3,3,1),plot(t,test_vx);
title('�����ٶȱ仯ͼ');
xlabel('ʱ��(s)');ylabel('�����ٶ�(m/s)');grid on;

subplot(3,3,2),plot(t,test_vy);
title('�����ٶȱ仯ͼ');
xlabel('ʱ��(s)');ylabel('�����ٶ�(m/s)');grid on;

subplot(3,3,3),plot(t,test_vz);
title('�����ٶȱ仯ͼ');
xlabel('ʱ��(s)');ylabel('�����ٶ�(m/s)');grid on;
% %************************����λ������ͼ******************************
subplot(3,3,4),plot(t,test_longitude./d2r);
title('����(longitude)�仯ͼ');
xlabel('ʱ��(s)');ylabel('����(��)');grid on;

subplot(3,3,5),plot(t,test_latitude./d2r);
title('γ��(latitude)�仯ͼ');
xlabel('ʱ��(s)');ylabel('γ��(��)');grid on;

subplot(3,3,6),plot(t,test_height);
title('�߶ȱ仯ͼ');
xlabel('ʱ��(s)');ylabel('�߶�(m)');grid on;
% %****************************������̬����ͼ*****************************

subplot(3,3,7),plot(t,test_yaw./d2r);
title('�����(phi)�仯ͼ');
xlabel('ʱ��(s)');ylabel('�����(��)');grid on;

subplot(3,3,8),plot(t,test_pitch./d2r);
title('������(theta)�仯ͼ');
xlabel('ʱ��(s)');ylabel('������(��)');grid on;

subplot(3,3,9),plot(t,test_roll./d2r);
title('�����(gamma)�仯ͼ');
xlabel('ʱ��(s)');ylabel('�����(��)');grid on;
