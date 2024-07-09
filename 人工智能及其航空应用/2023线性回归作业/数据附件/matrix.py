import math
import numpy as np
if __name__=="__main__":
    X1 = []
    X2 = []
    Y = []
    filename = "ex1data2.txt"
    with open(filename, 'r') as file_to_read:#读取数据
        while True:
            lines = file_to_read.readline()
            if not lines:
                break
                pass
            x1_tmp, x2_tmp, y_tmp = [float(i) for i in lines.split(",")]
            X1.append(x1_tmp)
            X2.append(x2_tmp)
            Y.append(y_tmp)
    pass
    X1 = np.array(X1)
    X2 = np.array(X2)
    O = np.ones(len(X1)+1)
    Y = np.array(Y)
    X = np.array(list(zip(O,X1,X2)))#将第一列第二列合成一个X矩阵
    Z = np.linalg.inv((X.T)@X)#求XXT的逆矩阵
    theta = Z@(X.T)@Y#代入公式
    print(theta)
    #for i in range(0, len(X)):
    #    A = theta.T@X[i]
    #    print(A)





