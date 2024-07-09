%% Origin
%F-16 models
a = [ -1.9311e-02  8.8157e+00 -3.2170e+01 -5.7499e-01;
         -2.5389e-04 -1.0189e+00  0.0000e+00  9.0506e-01;
          0.0000e-04   0.0000e+00  0.0000e+00 1.0000e+00;
          2.9465e-12   8.2225e-01   0.0000e+00 -1.0774e+00] ;
b = [ 1.7370e-01;
        -2.1499e-03;
         0.0000e+00;
        -1.7555e-01];
c = [ 0.000000e+00 5.729578e+01 0.000000e+00 0.000000e+00;
         0.000000e+00 0.000000e+00 0.000000e+00 5.729578e+01];
%% SAS
%augmented coefficientmatrices
ba = [0, 0, 0, 0, 22, 0]';
aa = [a -b [0,0,0,0]';
        -ba';
        0, 10.0, 0, 0, 0, -10.0];
ca = [c [0,0]' [0,0]';
        0,0,0,0,0, 57.29578];
%alpha-loop
k = logspace(-2, 1, 2000);
r = rlocus(aa, ba, ca(3,:),0,k); % 3rd row of C
figure(1);
plot(r)
grid on
axis([-20, 1, -10, 10])

%the effect of varying kq, with ka fixed at 0.5
%ka = 0.05;
% acl = aa- ba * ka * ca(3,:); % Choose
% %[z,p,k] = ss2zp(acl,ba,ca(2,:),0); % q/u transf. fn
% r = rlocus(acl, ba, ca(2,:),0);
% figure(2);
% plot(r)
% grid on

acl= aa - ba*0.1*ca(3,:); % Close alpha loop, Ka
qfb= ss(acl,ba,ca(2,:),0); % SISO system for q f.b.
z=3; p=1;lag= ss(-p,1,z-p,1); % Lag compensator
csys= series(lag,qfb); % Cascade Comp. before plant
[a,b,c,d]= ssdata(csys);
k = logspace(-2,0,2000);
r = rlocus(a,b,c,d,k);
figure(2);
plot(r)
grid on
figure(3);
sys = ss(a,b,c,d);
bode(sys);
margin(sys);
grid on;
%% qCAS
ap=[-1.0189 0.90506; 0.82225 -1.0774]; % x1= alpha x2=q
bp=[-2.1499E-3; -1.7555E-1]; % Elevator input
cp=[57.29578 0; 0 57.29578]; % y1= alpha, y2= q
dp=[0;0];
sysp= ss(ap,bp,cp,dp); % Plant
sysa= ss(-22, 22, -1, 0); % Actuator & SIGN CHANGE
[sys1]= series(sysa,sysp); % Actuator then Plant
sysf= ss(-10,[10 0],[1; 0],[0 0; 0 1]); % Alpha Filter
[sys2]= series(sys1,sysf); % Actuator+Plant+Filter
[a,b,c,d]= ssdata(sys2); % Extract a,b,c,d
ka = 0.08;
acl= a - b*[ka 0]*c; % Close Alpha-loop
%[z,p,k] = ss2zp(acl,b,c(2,:),0); % q/u1 transf. fn.
sys3= ss(acl,b,c,[0;0]); % Alpha-loop closed
sysi= ss(0,3,1,1); % PI= (s+3)/s
sys4= series(sysi,sys3); % x1=alpha-f,,,x5= PI
[aa,bb,cc,dd]= ssdata(sys4);
k= linspace(0,2,1000);
r= rlocus(aa,bb,cc(2,:),0,k);
figure(4)
plot(r)
grid on
figure(5)
acl2= aa- bb*0.5*cc(2,:); % close outer loop
sys= ss(acl2,0.5*bb,cc(2,:),0); % unity feedback
step(sys,5)
hold on
% no integral action, no zero
sysi= ss(0,1,1,0);
sys4= series(sysi,sys3); % x1=alpha-f,,,x5= PI
[aa,bb,cc,dd]= ssdata(sys4);
acl2= aa- bb*0.5*cc(2,:); % close outer loop
sys1= ss(acl2,0.5*bb,cc(2,:),0); % unity feedback
step(sys1,5)
figure(6)
sys = ss(aa,bb,cc(2,:),0);
bode(sys);
margin(sys);
%% nzCAS
ap=[-1.0189 0.90506; 0.82225 -1.0774]; % x1= alpha x2=q
bp=[-2.1499E-3; -1.7555E-1]; % Elevator input
cp=[0 57.29578; 16.262 0.97877]; % y1=q y2= an
dp=[0; -0.048523];
sysp= ss(ap,bp,cp,dp); % Plant
sysa= ss(-10, 10, -1,0); % Actuator, SIGN CHANGE
[sys1]= series(sysa,sysp); % Actuator then Plant
[a,b,c,d]= ssdata(sys1); % an/u transfer fn.
acl= a - b*[0.5 0]*c; % Close q loop
%[z,p,k] = ss2zp(acl,b,c(2,:),d); % an/u1 transfer fn.
sys3= ss(acl,b,c,[0;0]); % Alpha-loop closed
sysi= ss(0,3,1,1); % PI= (s+3)/s
sys4= series(sysi,sys3); % x1=alpha-f,,,x5= PI
[aa,bb,cc,dd]= ssdata(sys4);
k= linspace(0,30,1000);
r= rlocus(aa,bb,cc(2,:),0,k);
figure(7)
plot(r)
grid on
figure(8)
acl2= aa- bb*0.4*cc(2,:); % close outer loop
sys= ss(acl2,0.4*bb,cc(2,:),0); % unity feedback
step(sys,20)
hold on
% no integral action, no zero
sysi= ss(0,1,1,0);
sys4= series(sysi,sys3); % x1=alpha-f,,,x5= PI
[aa,bb,cc,dd]= ssdata(sys4);
acl2= aa- bb*0.4*cc(2,:); % close outer loop
sys1= ss(acl2,0.4*bb,cc(2,:),0); % unity feedback
step(sys1,20)
figure(9)
sys = ss(aa,bb,cc(2,:),0);
bode(sys);
margin(sys);