% 参数设置
v = 10; % 火车的匀速
T_system = 1; % 系统更新周期（秒）
T_measurement = 5; % 外部测量周期（秒）
total_time = 100; % 总仿真时间（秒）
noise_level = 5; % 扰动力噪声水平
m = 1; % 火车的质量

% 初始化变量
t = 0:T_system:total_time; % 时间向量
position_true = zeros(size(t)); % 初始化火车真实位置向量
velocity_true = v * ones(size(t)); % 初始化火车真实速度向量
measurement = NaN(size(t)); % 初始化测量向量
position_estimate = zeros(size(t)); % 初始化火车位置估计向量
velocity_estimate = zeros(size(t)); % 初始化火车速度估计向量

% 卡尔曼滤波器参数
Q = diag([0.1, 0.1]); % 过程噪声协方差
R = 10; % 测量噪声协方差
x_hat = [0; v]; % 初始状态估计 [位置; 速度]
P = diag([1, 1]); % 初始估计误差协方差

% 系统状态转移矩阵
A = [1 T_system;
     0 1];
B = [(T_system * T_system) / 2;
    T_system];

% 观测矩阵
H = [1 0];

% 仿真循环
for i = 1:length(t)
    % 更新火车真实位置和速度
    if i > 1
        position_true(i) = position_true(i-1) + velocity_true(i-1) * T_system + noise_level * (2 * rand() - 1) * (T_system * T_system) / (2 * m);
        velocity_true(i) = velocity_true(i-1) + noise_level * (2 * rand() - 1) * T_system / m;
    end
    
    % 外部测量
    if rem(i, T_measurement) == 0
        measurement(i) = position_true(i) + sqrt(R) * randn(); % 添加测量噪声
    end
    
    % 卡尔曼滤波器预测步骤
    x_hat_pred = A * x_hat + B * noise_level * (2 * rand() - 1) / m; % 预测下一个状态
    P_pred = A * P * A' + Q; % 预测下一个估计误差协方差
    
    % 卡尔曼滤波器更新步骤
    if rem(i, T_measurement) == 0
        K = P_pred * H' / (H * P_pred * H' + R); % 卡尔曼增益
        x_hat = x_hat_pred + K * (measurement(i) - H * x_hat_pred); % 更新状态估计
        P = (eye(2) - K * H) * P_pred; % 更新估计误差协方差
    else
        x_hat = x_hat_pred; % 如果没有测量，则使用预测值
        P = P_pred;
    end
    
    % 保存估计值
    position_estimate(i) = x_hat(1);
    velocity_estimate(i) = x_hat(2);
end

% 绘制结果曲线
figure;
subplot(2,1,1);
plot(t, position_true, 'b', t, position_estimate, 'r--', t, measurement, 'g.');
title('火车位置、估计位置和测量位置');
xlabel('时间 (s)');
ylabel('位置 (m)');
legend('实际位置', '估计位置', '测量位置');

subplot(2,1,2);
plot(t, velocity_true, 'b', t, velocity_estimate, 'r--');
title('火车速度和估计速度');
xlabel('时间 (s)');
ylabel('速度 (m/s)');
legend('实际速度', '估计速度');
