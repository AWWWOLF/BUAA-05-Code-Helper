A = [ -1.9311e-02  8.8157e+00 -3.2170e+01 -5.7499e-01;
         -2.5389e-04 -1.0189e+00  0.0000e+00  9.0506e-01;
          0.0000e-04   0.0000e+00  0.0000e+00 1.0000e+00;
          2.9465e-12   8.2225e-01   0.0000e+00 -1.0774e+00] ;
B = [ 1.7370e-01;
        -2.1499e-03;
         0.0000e+00;
        -1.7555e-01] ;
C = [ 0.000000e+00 5.729578e+01 0.000000e+00 0.000000e+00 ;
         0.000000e+00 0.000000e+00 0.000000e+00 5.729578e+01] ;
D = [0;0] ;
[V,d] = eig(A);%得到纵向特征值和特征向量
[num, den] = ss2tf(A,B,C,D);%状态空间函数转化为传递函数
alpha = tf(num(1,:),den);%得到迎角的传递函数
q = tf(num(2, :), den);%得到俯仰角速度的传递函数
% [z_alpha,p_alpha,k_alpha] = zpkdata(alpha, 'v') ;%得到迎角传递函数的零极点和增益
% [z_q, p_q, k_q] = zpkdata(q, 'v') ;%得到俯仰角速度传递函数的零极点和增益
% alpha = zpk(z_alpha, p_alpha, k_alpha) %得到零极点形式的迎角传递函数
% q = zpk(z_q, p_q, k_q)%得到零极点形式的俯仰角速度传递函数

% 飞机原始动态特性
% figure(1);
% bode(alpha);
% figure(2);
% bode(q);

%内环阻尼反馈
s = tf('s');
Gact = -10/(s+10);%舵回路传递函数
figure(3);
rlocus(q*Gact);
kq = 0.3;%内环增益
R1 = rlocus(q*Gact,kq);
Wn_sp = abs(R1(1));
T_sp = 2*pi/abs(imag(R1(1)));
zeta_sp = -real(R1(1))/Wn_sp;

%外环姿态角反馈
Gqq = feedback(Gact*q,kq);%计算阻尼反馈确定后的闭环传递函数
kxita = 0.5;
Gint = 1/s;
figure(4);
rlocus(Gqq*Gint);
R2 = rlocus(Gqq*Gint,kxita);
Wn_sp2 = abs(R2(1));
T_sp2 = 2*pi/abs(imag(R2(1)));
zeta_sp2 = -real(R2(1))/Wn_sp;

%检查稳定裕度
figure(5);
margin(kxita*Gqq*Gint)


