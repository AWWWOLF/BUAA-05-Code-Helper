import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
if __name__ == "__main__":
    X = []
    Y = []
    filename = "ch6_kmeans_data1.txt"
    with open(filename, 'r') as file_to_read:  # 读取数据
        while True:
            lines = file_to_read.readline()
            if not lines:
                break
                pass
            x_tmp, y_tmp = [float(i) for i in lines.split("	")]
            X.append(x_tmp)
            Y.append(y_tmp)
    pass
    X = np.array(X)
    Y = np.array(Y)
    A = np.array(list(zip(X, Y)))
    n_clusters = 6
    cluster = KMeans(n_clusters=n_clusters, random_state=6)
    cluster = cluster.fit(A)  # 导入包，运用函数进行训练
    y_pred = cluster.fit_predict(A)  # 取得分类后每个数据的类别，以便于画图
    print(cluster.cluster_centers_)  # 返回得到的几个质心坐标
    color = ['pink', 'black', 'green', 'blue', 'brown', 'purple']
    for i in range(6):  # 按照不同聚类用不同的颜色打印点
        plt.scatter(A[y_pred == i, 0], A[y_pred == i, 1],
                    marker='o',
                    s=8,
                    c=color[i])
    plt.scatter(cluster.cluster_centers_[:, 0], cluster.cluster_centers_[:, 1],
                marker='x',
                s=20,
                c='red')
    plt.show()
