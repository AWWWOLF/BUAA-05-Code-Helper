%读入数据
load('pdata.mat');
x1 = pdata(1:39971, :);
x2 = pdata(39972:73006, :);
x3 = pdata(73007:106041, :);
x4 = pdata(106042:139023, :);
x5 = pdata(139024:172062, :);
x6 = pdata(172063:205072, :);
x7 = pdata(205073:238090, :);
x8 = pdata(238091:271073, :);
x9 = pdata(271074:304115, :);
x10 = pdata(304116:337103, :);
x11 = pdata(337104:370135, :);
x12 = pdata(370136:403076, :);
x13 = pdata(403077:436118, :);
x14 = pdata(436119:468144, :);
x15 = pdata(478145:502183, :);
x16 = pdata(502184:length(pdata), :);
%常数
g = 9.8016;
%%
%求加表参数
fx1 = 0.0;
fy1 = 0.0;
fz1 = 0.0;
for i = 1:(length(x1) + length(x2) + length(x3) + length(x4))
    if i > length(x3) + length(x2) + length(x1) && i <= length(x4) + length(x3) + length(x2) + length(x1)
        j = i - length(x1) - length(x2) - length(x3);
        fx1 = fx1 + x4(j, 4);
        fy1 = fy1 + x4(j, 5);
        fz1 = fz1 + x4(j, 6);
    end
    if i > length(x2) + length(x1) && i <= length(x3) + length(x2) + length(x1)
        j = i - length(x1) - length(x2);
        fx1 = fx1 + x3(j, 4);
        fy1 = fy1 + x3(j, 5);
        fz1 = fz1 + x3(j, 6);
    end
    if i > length(x1) && i <= length(x2) + length(x1)
        j = i - length(x1);
        fx1 = fx1 + x2(j, 4);
        fy1 = fy1 + x2(j, 5);
        fz1 = fz1 + x2(j, 6);
    end
    if i <= length(x1)
        fx1 = fx1 + x1(i, 4);
        fy1 = fy1 + x1(i, 5);
        fz1 = fz1 + x1(i, 6);
    end
end
fx1 = fx1 / (length(x1) + length(x2) + length(x3) + length(x4));
fy1 = fy1 / (length(x1) + length(x2) + length(x3) + length(x4));
fz1 = fz1 / (length(x1) + length(x2) + length(x3) + length(x4));
fx2 = 0.0;
fy2 = 0.0;
fz2 = 0.0;
for i = 1:(length(x9) + length(x10) + length(x11) + length(x12))
    if i > length(x9) + length(x10) + length(x11) && i <= length(x12) + length(x9) + length(x10) + length(x11)
        j = i - length(x11) - length(x10) - length(x9);
        fx2 = fx2 + x12(j, 4);
        fy2 = fy2 + x12(j, 5);
        fz2 = fz2 + x12(j, 6);
    end
    if i > length(x9) + length(x10) && i <= length(x11) + length(x9) + length(x10)
        j = i - length(x10) - length(x9);
        fx2 = fx2 + x11(j, 4);
        fy2 = fy2 + x11(j, 5);
        fz2 = fz2 + x11(j, 6);
    end
    if i > length(x9) && i <= length(x10) + length(x9)
        j = i - length(x9);
        fx2 = fx2 + x10(j, 4);
        fy2 = fy2 + x10(j, 5);
        fz2 = fz2 + x10(j, 6);
    end
    if i <= length(x9)
        fx2 = fx2 + x9(i, 4);
        fy2 = fy2 + x9(i, 5);
        fz2 = fz2 + x9(i, 6);
    end
end
fx2 = fx2 / (length(x9) + length(x10) + length(x11) + length(x12));
fy2 = fy2 / (length(x9) + length(x10) + length(x11) + length(x12));
fz2 = fz2 / (length(x9) + length(x10) + length(x11) + length(x12));
fx3 = 0.0;
fy3 = 0.0;
fz3 = 0.0;
for i = 1:(length(x15) + length(x5))
    if i > length(x5)
        j = i - length(x5);
        fx3 = fx3 + x15(j, 4);
        fy3 = fy3 + x15(j, 5);
        fz3 = fz3 + x15(j, 6);
    end
    if i <= length(x5)
        fx3 = fx3 + x5(i, 4);
        fy3 = fy3 + x5(i, 5);
        fz3 = fz3 + x5(i, 6);
    end
end
fx3 = fx3 / (length(x15) + length(x5));
fy3 = fy3 / (length(x15) + length(x5));
fz3 = fz3 / (length(x15) + length(x5));
fx4 = 0.0;
fy4 = 0.0;
fz4 = 0.0;
for i = 1:(length(x7) + length(x13))
    if i > length(x7)
        j = i - length(x7);
        fx4 = fx4 + x13(j, 4);
        fy4 = fy4 + x13(j, 5);
        fz4 = fz4 + x13(j, 6);
    end
    if i <= length(x7)
        fx4 = fx4 + x7(i, 4);
        fy4 = fy4 + x7(i, 5);
        fz4 = fz4 + x7(i, 6);
    end
end
fx4 = fx4 / (length(x7) + length(x13));
fy4 = fy4 / (length(x7) + length(x13));
fz4 = fz4 / (length(x7) + length(x13));
fx5 = 0.0;
fy5 = 0.0;
fz5 = 0.0;
for i = 1:(length(x6) + length(x16))
    if i > length(x6)
        j = i - length(x6);
        fx5 = fx5 + x16(j, 4);
        fy5 = fy5 + x16(j, 5);
        fz5 = fz5 + x16(j, 6);
    end
    if i <= length(x6)
        fx5 = fx5 + x6(i, 4);
        fy5 = fy5 + x6(i, 5);
        fz5 = fz5 + x6(i, 6);
    end
end
fx5 = fx5 / (length(x6) + length(x16));
fy5 = fy5 / (length(x6) + length(x16));
fz5 = fz5 / (length(x6) + length(x16));
fx6 = 0.0;
fy6 = 0.0;
fz6 = 0.0;
for i = 1:(length(x8) + length(x14))
    if i > length(x8)
        j = i - length(x8);
        fx6 = fx6 + x14(j, 4);
        fy6 = fy6 + x14(j, 5);
        fz6 = fz6 + x14(j, 6);
    end
    if i <= length(x8)
        fx6 = fx6 + x8(i, 4);
        fy6 = fy6 + x8(i, 5);
        fz6 = fz6 + x8(i, 6);
    end
end
fx6 = fx6 / (length(x8) + length(x14));
fy6 = fy6 / (length(x8) + length(x14));
fz6 = fz6 / (length(x8) + length(x14));
%%
%加表零偏
aBx = (fx5 + fx6) / 2;
aBy = (fy3 + fy4) / 2;
aBz = (fz1 + fz2) / 2;
%加表标度
aSFx = (fx5 - fx6) / ( 2 * g );
aSFy = (fy3 - fy4) / ( 2 * g );
aSFz = (fz1 - fz2) / ( 2 * g );
%加表安装误差
aMAyx = (fy5 - fy6) / ( 2 * g ) / aSFy;
aMAzx = (fz5 - fz6) / ( 2 * g ) / aSFz;
aMAxy = (fx3 - fx4) / ( 2 * g ) / aSFx;
aMAzy = (fz3 - fz4) / ( 2 * g ) / aSFz;
aMAxz = (fx1 - fx2) / ( 2 * g ) / aSFx;
aMAyz = (fy1 - fy2) / ( 2 * g ) / aSFy;
%%
%读入数据
load("vdata.mat");
wx1 = vdata(1:38466, 1);
wx2 = vdata(38467:54430, 1);
wx3 = vdata(54431:63499, 1);
wx4 = vdata(63500:72505, 1);
wx5 = vdata(72506:81615, 1);
wx6 = vdata(81616:87461, 1);
wx7 = vdata(87462:94374, 1);
wx8 = vdata(94375:131227, 1);
wx9 = vdata(131228:147189, 1);
wx10 = vdata(147190:156077, 1);
wx11 = vdata(156078:165271, 1);
wx12 = vdata(165272:175057, 1);
wx13 = vdata(175058:180406, 1);
wx14 = vdata(180407:187691, 1);
wxvalues = {wx1, wx2, wx3, wx4, wx5, wx6, wx7, wx8, wx9, wx10, wx11, wx12, wx13, wx14};
wxkeys = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14"];
wx = dictionary(wxkeys,wxvalues);
wy1 = vdata(187692:227297, 3);
wy2 = vdata(227298:242567, 3);
wy3 = vdata(242568:251568, 3);
wy4 = vdata(251569:259095, 3);
wy5 = vdata(259096:268744, 3);
wy6 = vdata(268745:275602, 3);
wy7 = vdata(275603:282044, 3);
wy8 = vdata(282045:319337, 3);
wy9 = vdata(319338:335350, 3);
wy10 = vdata(335351:344728, 3);
wy11 = vdata(344729:354419, 3);
wy12 = vdata(354420:362808, 3);
wy13 = vdata(362809:369337, 3);
wy14 = vdata(369338:375689, 3);
wzvalues = {wy1, wy2, wy3, wy4, wy5, wy6, wy7, wy8, wy9, wy10, wy11, wy12, wy13, wy14};
wzkeys = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14"];
wz = dictionary(wzkeys,wzvalues);
wz1 = vdata(375690:416412, 2);
wz2 = vdata(416413:430702, 2);
wz3 = vdata(430703:439663, 2);
wz4 = vdata(439664:448688, 2);
wz5 = vdata(448689:457734, 2);
wz6 = vdata(457735:464088, 2);
wz7 = vdata(464089:470718, 2);
wz8 = vdata(470719:510246, 2);
wz9 = vdata(510247:523768, 2);
wz10 = vdata(523769:532857, 2);
wz11 = vdata(532858:542978, 2);
wz12 = vdata(542979:550999, 2);
wz13 = vdata(551000:557165, 2);
wz14 = vdata(557166:length(vdata), 2);
wyvalues = {wz1, wz2, wz3, wz4, wz5, wz6, wz7, wz8, wz9, wz10, wz11, wz12, wz13, wz14};
wykeys = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14"];
wy = dictionary(wykeys,wyvalues);
%%
%角速度分组
M = 14;omega = [1,5,10,30,50,100,200,-1,-5,-10,-30,-50,-100,-200];
Wx = zeros(1,14);Wy = zeros(1,14);Wz = zeros(1,14);
for i = 1:14
    k = num2str(i);
    ax = cell2mat(wx(k));
    ay = cell2mat(wy(k));
    az = cell2mat(wz(k));
    for j = 1 : length(ax)
        Wx(i) = Wx(i) + ax(j);
    end
    for j = 1 : length(ay)
        Wy(i) = Wy(i) + ay(j);
    end
    for j = 1 : length(az)
        Wz(i) = Wz(i) + az(j);
    end
    Wx(i) = Wx(i)/length(ax);
    Wy(i) = Wy(i)/length(ay);
    Wz(i) = Wz(i)/length(az);
end
%计算需要的参数
Wx1 = mean(x4(500:30500,1));
Wy2 = mean(x3(500:30500,2));
Wz3 = mean(x5(500:30500,3));
%零偏
Wx0 = 0.0;
Wy0 = 0.0;
Wz0 = 0.0;
for i = 1:(length(x2) + length(x4) + length(x10) + length(x12))
    if i > length(x2) + length(x4) + length(x10) && i <= length(x12) + length(x2) + length(x4) + length(x10)
        j = i - length(x4) - length(x2) - length(x10);
        Wx0 = Wx0 + x12(j, 1);
    end
    if i > length(x2) + length(x4) && i <= length(x10) + length(x2) + length(x4)
        j = i - length(x2) - length(x4);
        Wx0 = Wx0 + x10(j, 1);
    end
    if i > length(x2) && i <= length(x4) + length(x2)
        j = i - length(x2);
        Wx0 = Wx0 + x4(j, 1);
    end
    if i <= length(x2)
        Wx0 = Wx0 + x2(i, 1);
    end
end
Wx0 = Wx0 / (length(x2) + length(x4) + length(x10) + length(x12));
for i = 1:(length(x1) + length(x3) + length(x9) + length(x11))
    if i > length(x1) + length(x3) + length(x9) && i <= length(x11) + length(x1) + length(x3) + length(x9)
        j = i - length(x1) - length(x3) - length(x9);
        Wy0 = Wy0 + x11(j, 2);
    end
    if i > length(x1) + length(x3) && i <= length(x1) + length(x3) + length(x9)
        j = i - length(x1) - length(x3);
        Wy0 = Wy0 + x9(j, 2);
    end
    if i > length(x1) && i <= length(x1) + length(x3)
        j = i - length(x1);
        Wy0 = Wy0 + x3(j, 2);
    end
    if i <= length(x1)
        Wy0 = Wy0 + x1(i, 2);
    end
end
Wy0 = Wy0 / (length(x1) + length(x3) + length(x9) + length(x11));
for i = 1:(length(x5) + length(x6) + length(x7) + length(x8))
    if i > length(x5) + length(x6) + length(x7) && i <= length(x5) + length(x6) + length(x7) + length(x8)
        j = i - length(x5) - length(x6) - length(x7);
        Wz0 = Wz0 + x8(j, 3);
    end
    if i > length(x5) + length(x6) && i <= length(x5) + length(x6) + length(x7)
        j = i - length(x5) - length(x6);
        Wz0 = Wz0 + x7(j, 3);
    end
    if i > length(x5) && i <= length(x5) + length(x6)
        j = i - length(x5);
        Wz0 = Wz0 + x6(j, 3);
    end
    if i <= length(x5)
        Wz0 = Wz0 + x5(i, 3);
    end
end
for i = 1:(length(x13) + length(x14) + length(x15) + length(x16))
    if i > length(x13) + length(x14) + length(x15) && i <= length(x13) + length(x14) + length(x15) + length(x16)
        j = i - length(x13) - length(x14) - length(x15);
        Wz0 = Wz0 + x16(j, 3);
    end
    if i > length(x13) + length(x14) && i <= length(x13) + length(x14) + length(x15)
        j = i - length(x13) - length(x14);
        Wz0 = Wz0 + x15(j, 3);
    end
    if i > length(x13) && i <= length(x13) + length(x14)
        j = i - length(x13);
        Wz0 = Wz0 + x14(j, 3);
    end
    if i <= length(x13)
        Wz0 = Wz0 + x13(i, 3);
    end
end
Wz0 = Wz0 / (length(x5) + length(x6) + length(x7) + length(x8) + length(x13) + length(x14) + length(x15) + length(x16));
%%
gBx = Wx1;
gBy = Wy2;
gBz = Wz3;
%X陀螺标度
upx = 0.0;
downx = 0.0;
for j = 1 : M
    upx = upx + omega(j) * ( Wx(j) - Wx0);
    downx = downx + omega(j) * omega(j);
end
gSFx = upx / downx;
%Y陀螺标度
upy = 0.0;
downy = 0.0;
for j = 1 : M
    upy = upy + omega(j) * ( Wy(j) - Wy0);
    downy = downy + omega(j) * omega(j);
end
gSFy = upy / downy;
%Z陀螺标度
upz = 0.0;
downz = 0.0;
for j = 1 : M
    upz = upz + omega(j) * ( Wz(j) - Wz0);
    downz = downz + omega(j) * omega(j);
end
gSFz = upz / downz;
%X陀螺安装误差
Wyx1 = mean(vdata(87462:94374, 2));
Wzx1 = mean(vdata(87462:94374, 3));
Wyx2 = mean(vdata(180407:187691, 2));
Wzx2 = mean(vdata(180407:187691, 3));
gMAyx = (Wyx1 - Wyx2) / ( 2 * 200 * gSFy);
gMAzx = (Wzx1 - Wzx2) / ( 2 * 200 * gSFz);
%Y陀螺安装误差
Wxy1 = mean(vdata(464089:470718, 1));
Wzy1 = mean(vdata(464089:470718, 3));
Wxy2 = mean(vdata(557166:length(vdata), 1));
Wzy2 = mean(vdata(557166:length(vdata), 3));
gMAxy = (Wxy1 - Wxy2) / ( 2 * 200 * gSFx);
gMAzy = (Wzy1 - Wzy2) / ( 2 * 200 * gSFz);
%Z陀螺安装误差
Wyz1 = mean(vdata(275603:282044, 2));
Wxz1 = mean(vdata(275603:282044, 1));
Wyz2 = mean(vdata(369338:375689, 2));
Wxz2 = mean(vdata(369338:375689, 1));
gMAxz = (Wxz1 - Wxz2) / ( 2 * 200 * gSFx);
gMAyz = (Wyz1 - Wyz2) / ( 2 * 200 * gSFy);
%%
%加速度计补偿
fa1 = mean(pdata(1:120000,4));
fa2 = mean(pdata(1:120000,5));
fa3 = mean(pdata(1:120000,6));
A1 = inv([aSFx, aMAxy, aMAxz; aMAyx, aSFy, aMAyz; aMAzx, aMAzy, aSFz])*(transpose([fa1, fa2, fa3])-transpose([aBx, aBy, aBz]));
disp(A1);
g_hat = sqrt(sum(A1.^2));
disp(g_hat)
mae = abs(g - g_hat)/g;
disp(mae);
%%
%陀螺仪补偿
wa1 = mean(pdata(1:12000,1));
wa2 = mean(pdata(1:12000,2));
wa3 = mean(pdata(1:12000,3));
A2 = inv([gSFx, gMAxy, gMAxz; gMAyx, gSFy, gMAyz; gMAzx, gMAzy, gSFz])*(transpose([wa1, wa2, wa3])-transpose([gBx, gBy, gBz]));
disp(A2);
w_hat = sqrt(sum(A2.^2));
mae1 = abs(0.0042 - w_hat)/0.0042;
disp(w_hat);
disp(mae1);
%%
fprintf("aBx = %f \naBy = %f \naBz = %f \naSFx = %f \naSFy = %f \naSFz = %f \naMAyx = %f \naMAzx = %f \naMAxy = %f \naMAzy = %f \naMAxz = %f \naMAyz = %f \n", aBx, aBy, aBz, aSFx, aSFy, aSFz, aMAyx, aMAzx, aMAxy, aMAzy, aMAxz, aMAyz);
fprintf("gBx = %f \ngBy = %f \ngBz = %f \ngSFx = %f \ngSFy = %f \ngSFz = %f \ngMAyx = %f \ngMAzx = %f \ngMAxy = %f \ngMAzy = %f \ngMAxz = %f \ngMAyz = %f\n",gBx, gBy, gBz, gSFx, gSFy, gSFz, gMAyx, gMAzx, gMAxy, gMAzy, gMAxz, gMAyz);