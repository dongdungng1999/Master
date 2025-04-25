clc;
clear all;
pause on
d1=1; d2=5; d3=0; d4=7; d5=1;
home = [0;0;0;0;0;0];
tf = 1;
step = 0.2;
i_max = tf/step; j = 0;
p_e = zeros(i_max + 1,3);
The = zeros(i_max + 1,6);
p_i = [8;5;1];
p_f = [8;0;4];
a3 = -2/tf^3;
a2 =  3/tf^2;
tic
for t = 0:step:tf
pause(0)
j = j +1;
s = a3*t.^3 + a2*t.^2;
pe = p_i + s.*(p_f - p_i);
pe_x = pe(1,:);
pe_y = pe(2,:);
pe_z = pe(3,:);
p_e(j,1) = pe_x;
p_e(j,2) = pe_y;
p_e(j,3) = pe_z;
pe_dot = (p_f - p_i)*(3*a3*t.^2 + 2*a2*t);
pe_dot_x = pe_dot(1,:);
pe_dot_y = pe_dot(2,:);
pe_dot_z = pe_dot(3,:);
pe_dot_dot = (p_f -  p_i)*(6*a3*t + 2*a2);
pe_dot_dot_x = pe_dot_dot(1,:);
pe_dot_dot_y = pe_dot_dot(2,:);
pe_dot_dot_z = pe_dot_dot(3,:);
if j == 1
The_pre = IK_BD(p_e(1,1), p_e(1,2), p_e(1,3), pi, 0, 0, home(1), home(2), home(3), home(4), home(5), home(6));
end
The_current = IK_BD(p_e(j,1), p_e(j,2), p_e(j,3), pi, 0, 0, The_pre(1), The_pre(2), The_pre(3), The_pre(4), The_pre(5), The_pre(6));
    for k = 1:1:6
    The(j,k) = The_current(k);
    end
The_pre = The_current;
%% Plot quy dao
subplot(4,7,1);
title('Quang Duong');
plot(t,pe_x,'.r',t,pe_y,'.b',t,pe_z,'.k');
legend('X','Y','Z');
grid on
hold on
subplot(4,7,8);
plot(t,pe_dot_x,'.r',t,pe_dot_y,'.b',t,pe_dot_z,'.k');
legend('V_x','V_y','V_z');
title('Van Toc');
hold on;
subplot(4,7,15);
title('Gia Toc');
plot(t,pe_dot_dot_x,'.r',t,pe_dot_dot_y,'.b',t,pe_dot_dot_z,'.k');
legend('a_x','a_y','a_z');
hold on;
subplot(4,7,2);
title('Theta1');
plot(t,The(j,1),'.k');
hold on;
subplot(4,7,3);
title('Theta2');
plot(t,The(j,2),'.k');
hold on;
subplot(4,7,4);
title('Theta3');
plot(t,The(j,3),'.k');
hold on;
subplot(4,7,5);
title('Theta4');
plot(t,The(j,4),'.k');
hold on;
subplot(4,7,6);
title('Theta5');
plot(t,The(j,5),'.k');
hold on;
subplot(4,7,7);
title('Theta6');
plot(t,The(j,6),'.k');
hold on;
end
toc
%% Cubic(theta0, thetaf,tf,step,t0,row,collumn,pos1,pos2,pos3)
h = 2;
% Cubic(home(1), The(1,1), home(2), The(1,2), home(3), The(1,3), home(4), The(1,4), home(5), The(1,5), home(6), The(1,6), h, 0.2, 0,4, 7, 9, 16, 23, 10, 17, 24, 11, 18, 25, 12, 19, 26, 13, 20, 27, 14, 21, 28);
for j = 0:1:i_max-1
Cubic(The(j+1,1), The(j+2,1), The(j+1,2), The(j+2,2), The(j+1,3), The(j+2,3), The(j+1,4), The(j+2,4), The(j+1,5), The(j+2,5), The(j+1,6), The(j+2,6), step, step/10, h + j/10, 4, 7, 9, 16, 23, 10, 17, 24, 11, 18, 25, 12, 19, 26, 13, 20, 27, 14, 21, 28);
%Cubic2(The(j+1,1), The(j+2,1), step, step/10, 3 + j/10, 4, 7, 9, 16, 23);
end















