% ��������
v = 10; % �𳵵�����
T_system = 1; % ϵͳ�������ڣ��룩
T_measurement = 5; % �ⲿ�������ڣ��룩
total_time = 100; % �ܷ���ʱ�䣨�룩
noise_level = 5; % �Ŷ�������ˮƽ
m = 1; % �𳵵�����

% ��ʼ������
t = 0:T_system:total_time; % ʱ������
position_true = zeros(size(t)); % ��ʼ������ʵλ������
velocity_true = v * ones(size(t)); % ��ʼ������ʵ�ٶ�����
measurement = NaN(size(t)); % ��ʼ����������
position_estimate = zeros(size(t)); % ��ʼ����λ�ù�������
velocity_estimate = zeros(size(t)); % ��ʼ�����ٶȹ�������

% �������˲�������
Q = diag([0.1, 0.1]); % ��������Э����
R = 10; % ��������Э����
x_hat = [0; v]; % ��ʼ״̬���� [λ��; �ٶ�]
P = diag([1, 1]); % ��ʼ�������Э����

% ϵͳ״̬ת�ƾ���
A = [1 T_system;
     0 1];
B = [(T_system * T_system) / 2;
    T_system];

% �۲����
H = [1 0];

% ����ѭ��
for i = 1:length(t)
    % ���»���ʵλ�ú��ٶ�
    if i > 1
        position_true(i) = position_true(i-1) + velocity_true(i-1) * T_system + noise_level * (2 * rand() - 1) * (T_system * T_system) / (2 * m);
        velocity_true(i) = velocity_true(i-1) + noise_level * (2 * rand() - 1) * T_system / m;
    end
    
    % �ⲿ����
    if rem(i, T_measurement) == 0
        measurement(i) = position_true(i) + sqrt(R) * randn(); % ��Ӳ�������
    end
    
    % �������˲���Ԥ�ⲽ��
    x_hat_pred = A * x_hat + B * noise_level * (2 * rand() - 1) / m; % Ԥ����һ��״̬
    P_pred = A * P * A' + Q; % Ԥ����һ���������Э����
    
    % �������˲������²���
    if rem(i, T_measurement) == 0
        K = P_pred * H' / (H * P_pred * H' + R); % ����������
        x_hat = x_hat_pred + K * (measurement(i) - H * x_hat_pred); % ����״̬����
        P = (eye(2) - K * H) * P_pred; % ���¹������Э����
    else
        x_hat = x_hat_pred; % ���û�в�������ʹ��Ԥ��ֵ
        P = P_pred;
    end
    
    % �������ֵ
    position_estimate(i) = x_hat(1);
    velocity_estimate(i) = x_hat(2);
end

% ���ƽ������
figure;
subplot(2,1,1);
plot(t, position_true, 'b', t, position_estimate, 'r--', t, measurement, 'g.');
title('��λ�á�����λ�úͲ���λ��');
xlabel('ʱ�� (s)');
ylabel('λ�� (m)');
legend('ʵ��λ��', '����λ��', '����λ��');

subplot(2,1,2);
plot(t, velocity_true, 'b', t, velocity_estimate, 'r--');
title('���ٶȺ͹����ٶ�');
xlabel('ʱ�� (s)');
ylabel('�ٶ� (m/s)');
legend('ʵ���ٶ�', '�����ٶ�');
