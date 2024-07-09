import numpy as np
import matplotlib.pyplot as plt


def sig(x):  # 构造sigmord函数
    z = np.exp(-x)
    sigm = 1 / (1 + z)
    return sigm


if __name__ == "__main__":
    X1 = []
    X2 = []
    Y = []
    filename = "ex2data2.txt"
    with open(filename, 'r') as file_to_read:  # 读取数据
        while True:
            lines = file_to_read.readline()
            if not lines:
                break
            if lines == "\n":
                continue
            x1_tmp, x2_tmp, y_tmp = [float(i) for i in lines.split(",")]
            X1.append(x1_tmp)
            X2.append(x2_tmp)
            Y.append(y_tmp)
    X1 = np.array(X1)
    X2 = np.array(X2)
    ONE = np.ones(len(X1)+1)
    Y = np.array(Y)
    X = np.array(list(zip(ONE, X1, X2)))  # 将第一列第二列合成一个X矩阵
    theta0 = -1  # 设置theta0 theta1 theta2的初始值为-1、2、2
    theta1 = 2
    theta2 = 2
    theta = [theta0, theta1, theta2]
    theta = np.array(theta)
    temp0 = 1  # 设置初始梯度值
    temp1 = 1
    temp2 = 1
    while (abs(temp0) >= 0.001) or (abs(temp1) >= 0.001) or (abs(temp1) >= 0.001):  # 梯度下降法，判定值为0.001
        temp0 = 0  # 初始化梯度值
        temp1 = 0
        temp2 = 0
        for i in range(0, len(X)):
            for n in range(0, len(X)):  # 设置步长为0.0001
                H = sig(theta.T @ X[n])
                temp0 = temp0 + 0.0001 * (1 / len(X)) * (H - Y[n])
                temp1 = temp1 + 0.0001 * (1 / len(X)) * (H - Y[n]) * X1[n]
                temp2 = temp2 + 0.0001 * (1 / len(X)) * (H - Y[n]) * X2[n]
            theta0 = theta0 - temp0
            theta1 = theta1 - temp1
            theta2 = theta2 - temp2
        theta = [theta0, theta1, theta2]
        theta = np.array(theta)
        print(theta)
    x = np.linspace(-0.75, 1.00, 50)
    y = np.linspace(-0.75, 1.00, 50)
    x, y = np.meshgrid(x, y)
    z = theta1*np.power(x, 2)+theta2*np.power(y, 2)+theta0  # 把结果用椭圆方程表示
    for i in range(0, len(X1)):  # 画散点图，通过的是蓝色，不通过的是红色
        if Y[i] == 1:
            plt.scatter(X1[i], X2[i], c='blue')
        else:
            plt.scatter(X1[i], X2[i], c='red')
    plt.contour(x, y, z, 0)
    plt.show()