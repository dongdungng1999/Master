clear all
clc
The_pre = [0;145;0;0;-55;0];
d1=1; d2=5; d3=0; d4=7; d5=1; d6 = 1;
r = 2;
c = [5;2;10];
R = [1 0 0;
     0 -1 0;
     0 0 -1];
theta0 = pi;
thetaf = -9*pi;
tf = 8;
step = 0.1;
a5 =   6*(thetaf-theta0)/tf^5;
a4 = -15*(thetaf-theta0)/tf^4;
a3 =  10*(thetaf-theta0)/tf^3;
for t  = 0: step: tf
i = j + 1;
pause(step)
n        =    a5*t.^5  +    a4*t.^4 +   a3*t.^3 + theta0;
n_dot    =  5*a5*t.^4  +  4*a4*t.^3 + 3*a3*t.^2;
n_dotdot = 20*a5*t.^3  + 12*a4*t.^2 + 6*a3*t;
P_map = [r*cos(n);
         r*sin(n);
               0];                   
P_e        = c + R*P_map;
The_current = IK_BD(P_e(1), P_e(2), P_e(3), 0.3523,   -1.5708,    2.7892, The_pre(1), The_pre(2), The_pre(3), The_pre(4), The_pre(5), The_pre(6));
The_pre = The_current;

%% 3D PLANNING
% plot3(P_e(1),P_e(2),P_e(3),'.b')
% xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
% xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');
% hold on
flotrobot(The_current(1), The_current(2), The_current(3), The_current(4), The_current(5), The_current(6), d1, d2, d3, d4, d5,d6);
xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');

%% 2D PLANNING
% subplot(3,3,1);
% plot(t,P_e(1),'.r')
% title('X')
% hold on
% subplot(3,3,2);
% plot(t,P_e(2),'.r')
% title('Y')
% hold on
% subplot(3,3,3);
% plot(t,P_e(3),'.r')
% title('Z')
% hold on

end