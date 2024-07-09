%测试代码 num = homework('digital.jpg','svm_model.mat') 
function num = homework(imgPath,~) 
% 读取训练集图片文件，假设文件名为train-images.idx3-ubyte
fid = fopen('train-images.idx3-ubyte','r','b'); % 以二进制格式打开文件
fread(fid,4); % 跳过前四个字节
numimg = fread(fid,1,'int32'); % 读取图片数量
imgw = fread(fid,1,'int32'); % 读取图片宽度
imgh = fread(fid,1,'int32'); % 读取图片高度
data1 = fread(fid,numimg*imgw*imgh,'uint8'); % 读取图片像素值
fclose(fid); % 关闭文件

% 将data1转换为一个numimgx(imgw*imgh)的矩阵，每一行是一个样本
X1 = double(reshape(data1,imgw*imgh,numimg)');

% 读取训练集标签文件，假设文件名为train-labels.idx1-ubyte
fid = fopen('train-labels.idx1-ubyte','r','b'); % 以二进制格式打开文件
fread(fid,4); % 跳过前四个字节
numlbl = fread(fid,1,'int32'); % 读取标签数量
label1 = fread(fid,numlbl,'uint8'); % 读取标签值
fclose(fid); % 关闭文件

% 将label1转换为一个numlblx1的向量，每一行是一个标签
y1 = double(label1);

% 读取另一个训练集图片文件，假设文件名为train-images2.idx3-ubyte
fid = fopen('t10k-images.idx3-ubyte','r','b'); % 以二进制格式打开文件
fread(fid,4); % 跳过前四个字节
numimg = fread(fid,1,'int32'); % 读取图片数量
imgw = fread(fid,1,'int32'); % 读取图片宽度
imgh = fread(fid,1,'int32'); % 读取图片高度
data2 = fread(fid,numimg*imgw*imgh,'uint8'); % 读取图片像素值
fclose(fid); % 关闭文件

% 将data2转换为一个numimgx(imgw*imgh)的矩阵，每一行是一个样本
X2 = double(reshape(data2,imgw*imgh,numimg)');

% 读取另一个训练集标签文件，假设文件名为train-labels2.idx1-ubyte
fid = fopen('t10k-labels.idx1-ubyte','r','b'); % 以二进制格式打开文件
fread(fid,4); % 跳过前四个字节
numlbl = fread(fid,1,'int32'); % 读取标签数量
label2 = fread(fid,numlbl,'uint8'); % 读取标签值
% 关闭文件
fclose(fid); % 关闭文件

% 将label2转换为一个numlblx1的向量，每一行是一个标签
y2 = double(label2);

% 沿着第一维度（行）拼接两个矩阵和两个向量，得到更大的矩阵
X = cat(1,X1,X2); % 拼接图片矩阵
y = cat(1,y1,y2); % 拼接标签向量

% 随机划分训练集和测试集，80%用于训练，20%用于测试
rng(1);
% 设置随机数种子，保证每次运行结果一致
cv = cvpartition(y,'holdout',0.2);
% 生成交叉验证对象
X_train = X(cv.training,:);
% 提取训练集特征
y_train = y(cv.training);
% 提取训练集标签
X_test = X(cv.test,:);
% 提取测试集特征
%y_test = y(cv.test);
% 提取测试集标签

% 对训练集和测试集进行标准化处理，使每个特征的均值为0，方差为1
mu = mean(X_train);
% 计算训练集每个特征的均值
sigma = std(X_train);
% 计算训练集每个特征的标准差
X_train = (X_train - mu) ./ sigma;
% 对训练集进行标准化
X_test = (X_test - mu) ./ sigma;
% 对测试集进行标准化

% 保存训练集的均值和方差到文件中，以便后面使用
save('mu.mat','mu'); 
save('sigma.mat','sigma');

% 使用SVM训练分类器，使用高斯核函数，自动选择核参数和惩罚参数
%svm_model = fitcecoc(X_train,y_train,'Learners','linear','BinaryLoss','binodeviance');
%svm_model = fitcecoc(X_train,y_train,'Learners','guassian','BinaryLoss','binodeviance');
%t = templateSVM('Standardize',1); 
%svm_model = fitcecoc(X_train,y_train,'Learners',t);
%M = [1 0 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 0; 0 0 0 1 1 -1 -1 -1 -1 -1; -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
%fitcecoc(X,Y,'Learners',t,'ObservationsIn','columns') fitcecoc(X_train,y_train,'Coding',M,'Learners','linear');
svm_model = fitcecoc(X_train,y_train);
% 保存SVM模型到文件中，以便后面使用
save('svm_model.mat','svm_model');

% 使用SVM模型对测试集进行预测，得到预测的标签和分数
[~,~] = predict(svm_model,X_test);

% 计算并显示测试集的混淆矩阵和准确率
%cmat = confusionmat(y_test,label);
%disp('The confusion matrix is: ');
%disp(cmat);

% 读取要识别的图片文件
img = imread(imgPath);

% 调整图片大小为28x28像素，并转换为灰度图
img = imresize(img,[28 28]);
img = rgb2gray(img);
% 显示图片
%imshow(img);
% 将图片转换为一个行向量，每个元素是一个像素值
x = double(reshape(img,1,[]));

% 对图片进行标准化处理，使用训练集的均值和方差
x = (x - mu) ./ sigma;

% 对图片进行反色处理，使其与MNIST数据集保持一致
x = 255 - x;
% 加载SVM模型
%svm_mode1 = load(modelPath);
% 使用SVM模型对图片进行预测，得到预测的标签和分数
label= predict(svm_model,x);
%disp(['The predicted label is: ',num2str(label)]);
% 显示预测的标签和分数
num = label;
end