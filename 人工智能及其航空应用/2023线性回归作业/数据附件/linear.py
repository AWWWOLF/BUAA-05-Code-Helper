import math
import numpy as np
if __name__=="__main__":
    X = []
    Y = []
    filename = "ex1data1.txt"
    with open(filename, 'r') as file_to_read:#读取数据
        while True:
            lines = file_to_read.readline()
            if not lines:
                break
                pass
            x_tmp, y_tmp = [float(i) for i in lines.split(",")]
            X.append(x_tmp)
            Y.append(y_tmp)
    pass
    X = np.array(X)
    Y = np.array(Y)
    pass
    theta1 = []
    theta2 = []
    theta1.append(1)#设置一个二元的线性回归方程（y = theta1*x+theta2），预先设定theta1和theta2的初始值为1、-3
    theta2.append(-3)
    n = 1#设置theta角标和梯度初始值
    temp1 = 5
    temp2 = 5
    while((abs(temp1) >= 0.001)and(abs(temp2) >= 0.001)):#设判断值为0.001,如果任一梯度大于alpha就继续循环
        theta1.append(0)
        theta2.append(0)
        for i in range(1, len(X)):#做梯度下降运算,步长设为0.00004
            theta1[n] = theta1[n]+0.00004*(1/len(X))*(theta1[n-1]+theta2[n-1]*X[i]-Y[i])
            theta2[n] = theta2[n]+0.00004*(1/len(X))*(theta1[n-1]+theta2[n-1]*X[i]-Y[i])*X[i]
        temp1 = theta1[n]
        temp2 = theta2[n]
        theta1[n] = theta1[n-1]-temp1
        theta2[n] = theta2[n-1]-temp2
        print(theta1[n], theta2[n])#输出结果
        n = n+1





