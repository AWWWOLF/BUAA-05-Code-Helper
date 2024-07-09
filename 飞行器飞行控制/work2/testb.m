% 定义符号变量
syms s

% 定义公式
numerator = 56.14*(s+0.30)*(s+0.050)*(s+0.002264);
denominator = (s+6.29)*(s+2.75+12.03)*(s+0.673 +0.604i)*(s + 0.267)*(s+0.053)*(s + 0.00224);

% 将分子和分母转换为符号表达式
numerator_sym = sym(numerator);
denominator_sym = sym(denominator);

% 提取分子和分母的系数
num = coeffs(numerator_sym, s);
den = coeffs(denominator_sym, s);

% 由于 coeffs 函数返回的是细胞数组，需要将其转换为数值向量
num = [num{:}];
den = [den{:}];

% 创建传递函数对象
sys = tf(num, den);

% 获取零点、极点和增益
[z, p, k] = zpkdata(sys, 'modal');

% 提取固有频率和阻尼比
for i = 1:length(p)
    % 对于每个极点，计算阻尼比和固有频率
    lambda = real(p(i)); % 固有频率的平方
    omega_n = sqrt(lambda); % 固有频率
    zeta = -imag(p(i)) / (2 * omega_n); % 阻尼比
    fprintf('极点 %d: 固有频率 = %f rad/s, 阻尼比 = %f\n', i, omega_n, zeta);
end
