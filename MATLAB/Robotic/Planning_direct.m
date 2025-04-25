clear all
clc
The_pre = [0;145;0;0;-55;0];
d1=1; d2=5; d3=0; d4=7; d5=1; d6 = 1;
p_i = [8;6;2];
p_f = [8;9;4];
tf = 5;
step = 0.1;
a5 =   6/tf^5;
a4 = -15/tf^4;
a3 =  10/tf^3;
% for i = 0:6
for t  = 0: step: tf
pause(step)
s = a5*t.^5 + a4*t.^4 + a3*t.^3;
s_dot = 5*a5*t.^4  +  4*a4*t.^3 + 3*a3*t.^2;
s_dotdot = 20*a5*t.^3  + 12*a4*t.^2 + 6*a3*t;
pe = p_i + s.*(p_f - p_i);
pe_dot = (p_f - p_i)*s_dot;
pe_dotdot = (p_f - p_i)*s_dotdot;                   
The_current = IK_BD(pe(1), pe(2), pe(3), 1.5708,   -0.7854,   1.57082, The_pre(1), The_pre(2), The_pre(3), The_pre(4), The_pre(5), The_pre(6));
The_pre = The_current;

%% 3D PLANNING
% plot3(pe(1),pe(2),pe(3),'.b')
% xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
% xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');

flotrobot(The_current(1), The_current(2), The_current(3), The_current(4), The_current(5), The_current(6), d1, d2, d3, d4, d5,d6);
xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');

%% 2D PLANNING
% subplot(3,3,1);
% plot(t,pe(1),'.r','linewidth',5)
% title('X')
% hold on
% subplot(3,3,2);
% plot(t,pe(2),'.r','linewidth',5)
% title('Y')
% hold on
% subplot(3,3,3);
% plot(t,pe(3),'.r','linewidth',5)
% title('Z')
% hold on
% 
% subplot(3,3,4);
% plot(t,pe_dot(1),'.r','linewidth',5)
% title('Van toc theo phuong X')
% hold on
% subplot(3,3,5);
% plot(t,pe_dot(2),'.r','linewidth',5)
% title('Van toc theo phuong Y')
% hold on
% subplot(3,3,6);
% plot(t,pe_dot(3),'.r','linewidth',5)
% title('Van toc theo phuong Z')
% hold on
% 
% subplot(3,3,7);
% plot(t,pe_dotdot(1),'.r','linewidth',5)
% title('Gia toc theo phuong X')
% hold on
% subplot(3,3,8);
% plot(t,pe_dotdot(2),'.r','linewidth',5)
% title('Gia toc theo phuong Y')
% hold on
% subplot(3,3,9);
% plot(t,pe_dotdot(3),'.r','linewidth',5)
% title('Gia toc theo phuong Z')
% hold on

end
% for t  = 0: step: tf
% pause(step)
% s = a5*t.^5 + a4*t.^4 + a3*t.^3;
% s_dot = 5*a5*t.^4  +  4*a4*t.^3 + 3*a3*t.^2;
% s_dotdot = 20*a5*t.^3  + 12*a4*t.^2 + 6*a3*t;
% pe = p_f + s.*(p_i - p_f);
% pe_dot = (p_i - p_f)*s_dot;
% pe_dotdot = (p_i - p_f)*s_dotdot;                   
% The_current = IK_BD(pe(1), pe(2), pe(3), 1.5708,   -0.7854,   1.5708, The_pre(1), The_pre(2), The_pre(3), The_pre(4), The_pre(5), The_pre(6));
% The_pre = The_current;
% flotrobot(The_current(1), The_current(2), The_current(3), The_current(4), The_current(5), The_current(6), d1, d2, d3, d4, d5,d6);
% xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
% xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');
% end
% end