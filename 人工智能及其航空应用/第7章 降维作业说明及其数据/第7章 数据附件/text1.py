import numpy as np
import matplotlib.pyplot as plt


def svd(SUM):  # 构建SVD函数
    U, S, V = np.linalg.svd(SUM)
    return U, S, V


if __name__ == "__main__":
    X = []
    sum_x = 0
    sum_y = 0
    Y = []
    filename = "ch7_pca_data1.txt"
    with open(filename, 'r') as file_to_read:  # 读取数据
        while True:
            lines = file_to_read.readline()
            if not lines:
                break
                pass
            x_tmp, y_tmp = [float(i) for i in lines.split("	")]
            sum_x = sum_x + x_tmp
            sum_y = sum_y + y_tmp
            X.append(x_tmp)
            Y.append(y_tmp)
    pass
    X = np.array(X)
    Y = np.array(Y)
    for i in range(0, len(X)):
        X[i] = X[i] - sum_x / len(X)
        Y[i] = Y[i] - sum_y / len(Y)
    A = np.array(list(zip(X, Y)))
    SUM = [[0 for x in range(len(A))] for y in range(len(A))]
    for i in range(0, len(X)):  # 计算PCA中……
        C = A[i, :]
        SUM = SUM + C@C.T
    SUM = SUM/len(A)
    [U, S, V] = svd(SUM)
    U1 = U[:, 1]
    for i in range(0, len(X)):  # 得出一维特征，画出点
        Z = U1.T@A@A[i, :]
        plt.scatter(Z, 0)
    plt.show()
