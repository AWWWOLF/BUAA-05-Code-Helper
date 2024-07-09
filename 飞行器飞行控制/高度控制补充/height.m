clc;
clear;
close all;

%% 原始数据定义
% 定义飞行状态纵向矩阵
ap = [
    -0.0082354,  18.938,     -32.170,     0.0,        5.9022e-05;
    -0.00025617, -0.56761,    0.0,         1.0,        2.2633e-06;
    0.0,         0.0,         0.0,         1.0,        0.0;
    1.3114e-05,  -1.4847,     0.0,        -0.47599,   -1.4947e-07;
    0.0,        -500.00,     500.00,      0.0,        0.0
];

bp = [0; 0; 0; -0.019781; 0];

cp = [
    0, 0, 57.296, 0, 0;
    0, 0, 0, 57.296, 0
];

dp = [0; 0];

% 原始系统（飞行状态纵向矩阵）和执行器系统定义
plant = ss(ap, bp, cp, dp); % 飞行状态纵向系统
actuator = ss([-10], [10], [-1], [0]); % 执行器系统

%% 级联系统和引导补偿器设计
sys1 = series(actuator, plant); % 执行器和飞行状态纵向系统级联

% 提取级联后系统的状态空间参数
[a, b, c, d] = ssdata(sys1);

% 计算闭环系统的状态空间表示
acl = a - b * [3 2.5] * c;

% 设计引导补偿器
ch = [0 0 0 0 1 0];
[num, den] = ss2tf(acl,3*b,ch,0);
Gh_theta = (tf(num(1,:), den))

sys2 = ss(acl, 3 * b, ch, 0);

pole = 2;
lead = ss(-pole, pole, -0.875, 1); % 引导补偿器


sys3 = series(lead, sys2);
[a, b, c, d] = ssdata(sys3);

k = 5;
margin(a,k*b,c,0)
% 设计拉格（lag）补偿器并级联
lag = ss(-0.01, 0.01, 4, 1);
sys4 = series(lag, sys3);

% 提取级联后系统的状态空间参数
[a, b, c, d] = ssdata(sys4);
margin(a, 0.3333*b, c, 0);


% 计算新的闭环系统的状态空间表示
acl = a - 0.3333 * b * c;
closed_loop = ss(acl, 0.3333 * b, c, 0);

% 绘制步态响应
step(closed_loop, 30);
title('高度响应');
xlabel('Time (seconds)');
ylabel('高度');
grid on;


step_info = stepinfo(closed_loop);
fprintf('高度响应的动态性能指标:\n');
fprintf('上升时间: %.2f seconds\n', step_info.RiseTime);
fprintf('调节时间: %.2f seconds\n', step_info.SettlingTime);
fprintf('超调量: %.2f%%\n', step_info.Overshoot);

%{
各环节传递函数计算
[num, den] = ss2tf(-0.01, 0.01, 4, 1);
Gh_theta = (tf(num(1,:), den))
%}

