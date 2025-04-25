clc;
clear all;
tf = 1; l1 = 1; l2 = 1; i = 0;
step = 0.1;
i_max = (tf/step);
pi = [2;0];
pf = [0.5;1.866];
a3 = -2/tf^3;
a2 =  3/tf^2;
the = IK_RR(pi(1,:),pi(2,:),l1,l2);
the1 = the(1,:);
the2 = the(2,:);
j1 = zeros(i_max + 1,1);
j2 = zeros(i_max + 1,1);
for t = 0:step:tf
tic
i = i + 1;
s = a3*t.^3 + a2*t.^2;
pe = pi + s.*(pf - pi);
pe_x = pe(1,:);
pe_y = pe(2,:);
the = IK_RR(pe_x,pe_y,l1,l2);
the1_pre_i = the1;
the2_pre_i = the2;
the1_i = the(1,:); j1(i) = the1_i;
the2_i = the(2,:); j2(i) = the2_i;
pe_dot = (pf - pi)*(3*a3*t.^2 + 2*a2*t);
pe_dot_x = pe_dot(1,:);
pe_dot_dot = (pf -  pi)*(6*a3*t + 2*a2);
%% Plot quy dao
subplot(4,3,1);
plot(t,pe,'.r');
grid on
hold on
subplot(4,3,4);
plot(t,pe_dot,'.r');
title('Quy dao bac ba');
hold on;
subplot(4,3,7);
plot(t,pe_dot_dot,'.r');
hold on;
subplot(4,3,10);
plot([pi(1,:),pe(1,:)],[pi(2,:),pe(2,:)]);
hold on;
subplot(4,3,2);
plot(t,the1_i,'.r');
hold on;
subplot(4,3,3);
plot(t,the2_i,'.r');
hold on;
toc
end
%% Quy hoach khop 1
% a3 = -2*(j1(2)-j1(1))/(step)^3;
% a2 =  3*(j1(2)-j1(1))/(step)^2;
% t  = 0: step/100 : step,
% theta=a3*t.^3+a2*t.^2 + j1(1);
% thetad=3*a3*t.^2+2*a2*t;
% thetadd=6*a3*t+2*a2;
% subplot(3,1,1);
% plot(t,theta,'.r');
% grid on
% hold on
% subplot(3,1,2);
% plot(t,thetad,'.r');
% title('Quy dao bac ba');
% hold on;
% subplot(3,1,3);
% plot(t,thetadd,'.r');
% hold on;
% %%
% a3_2 = -2*(j1(3)-j1(2))/(step)^3;
% a2_2 =  3*(j1(3)-j1(2))/(step)^2;
% t  = 0: step/100 : step,
% theta=a3_2*t.^3+a2_2*t.^2 + j1(2);
% thetad=3*a3_2*t.^2+2*a2_2*t;
% thetadd=6*a3_2*t+2*a2_2;
% subplot(3,1,1);
% plot(t + step,theta,'.r');
% grid on
% hold on
% subplot(3,1,2);
% plot(t + step,thetad,'.r');
% title('Quy dao bac ba');
% hold on;
% subplot(3,1,3);
% plot(t + step,thetadd,'.r');
% hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Cubic(j1(1),j1(2),0.1,0.001,0);
% Cubic(j1(2),j1(3),0.1,0.001,0.1);
for i=0:1:i_max-1
Cubic2(j1(i+1),j1(i+2),step,step/10,i/10,4,3,5,8,11);
% Cubic(j2(i+1),j2(i+2),step,step/10,i/10,4,3,6,9,12);
end