function out = Cubic(theta0_1, thetaf_1,theta0_2, thetaf_2,theta0_3, thetaf_3,theta0_4, thetaf_4,theta0_5, thetaf_5,theta0_6, thetaf_6,tf,step,t0,row,collumn,pos1_1,pos2_1,pos3_1,pos1_2,pos2_2,pos3_2,pos1_3,pos2_3,pos3_3,pos1_4,pos2_4,pos3_4,pos1_5,pos2_5,pos3_5,pos1_6,pos2_6,pos3_6)
%% Quy dao bac ba
%join1
a3_1 = -2*(thetaf_1-theta0_1)/tf^3;
a2_1 =  3*(thetaf_1-theta0_1)/tf^2;
%join2
a3_2 = -2*(thetaf_2-theta0_2)/tf^3;
a2_2 =  3*(thetaf_2-theta0_2)/tf^2;
%join3
a3_3 = -2*(thetaf_3-theta0_3)/tf^3;
a2_3 =  3*(thetaf_3-theta0_3)/tf^2;
%join4
a3_4 = -2*(thetaf_4-theta0_4)/tf^3;
a2_4 =  3*(thetaf_4-theta0_4)/tf^2;
%join5
a3_5 = -2*(thetaf_5-theta0_5)/tf^3;
a2_5 =  3*(thetaf_5-theta0_5)/tf^2;
%join6
a3_6 = -2*(thetaf_6-theta0_6)/tf^3;
a2_6 =  3*(thetaf_6-theta0_6)/tf^2;
for t  = 0: step: tf
%%Join1
pause(0)
theta_1=a3_1*t.^3+a2_1*t.^2 + theta0_1;
thetad_1=3*a3_1*t.^2+2*a2_1*t;
thetadd_1=6*a3_1*t+2*a2_1;
subplot(row,collumn,pos1_1);
title('Vi tri khop 1');
plot(t + t0,theta_1,'.r');
grid on
hold on
subplot(row,collumn,pos2_1);
plot(t + t0,thetad_1,'.r');
title('Van toc khop 1');
hold on;
subplot(row,collumn,pos3_1);
title('Gia toc khop 1');
plot(t + t0,thetadd_1,'.r');
hold on;
%%Join2
theta_2=a3_2*t.^3+a2_2*t.^2 + theta0_2;
thetad_2=3*a3_2*t.^2+2*a2_2*t;
thetadd_2=6*a3_2*t+2*a2_2;
subplot(row,collumn,pos1_2);
title('Vi tri khop 2');
plot(t + t0,theta_2,'.r');
grid on
hold on
subplot(row,collumn,pos2_2);
plot(t + t0,thetad_2,'.r');
title('Van toc khop 2');
hold on;
subplot(row,collumn,pos3_2);
title('Gia toc khop 2');
plot(t + t0,thetadd_2,'.r');
hold on;
%Join3
theta_3=a3_3*t.^3+a2_3*t.^2 + theta0_3;
thetad_3=3*a3_3*t.^2+2*a2_3*t;
thetadd_3=6*a3_3*t+2*a2_3;
subplot(row,collumn,pos1_3);
title('Vi tri khop 3');
plot(t + t0,theta_3,'.r');
grid on
hold on
subplot(row,collumn,pos2_3);
plot(t + t0,thetad_3,'.r');
title('Van toc khop 3');
hold on;
subplot(row,collumn,pos3_3);
title('Gia toc khop 3');
plot(t + t0,thetadd_3,'.r');
hold on;
%Join 4
theta_4=a3_4*t.^3+a2_4*t.^2 + theta0_4;
thetad_4=3*a3_4*t.^2+2*a2_4*t;
thetadd_4=6*a3_4*t+2*a2_4;
subplot(row,collumn,pos1_4);
title('Vi tri khop 4');
plot(t + t0,theta_4,'.r');
grid on
hold on
subplot(row,collumn,pos2_4);
plot(t + t0,thetad_4,'.r');
title('Van toc khop 4');
hold on;
subplot(row,collumn,pos3_4);
title('Gia toc khop 4');
plot(t + t0,thetadd_4,'.r');
hold on;
%Join5
theta_5=a3_5*t.^3+a2_5*t.^2 + theta0_5;
thetad_5=3*a3_5*t.^2+2*a2_5*t;
thetadd_5=6*a3_5*t+2*a2_5;
subplot(row,collumn,pos1_5);
title('Vi tri khop 5');
plot(t + t0,theta_5,'.r');
grid on
hold on
subplot(row,collumn,pos2_5);
plot(t + t0,thetad_5,'.r');
title('Van toc khop 5');
hold on;
subplot(row,collumn,pos3_5);
title('Gia toc khop 5');
plot(t + t0,thetadd_5,'.r');
hold on;
%Join6
theta_6=a3_6*t.^3+a2_6*t.^2 + theta0_6;
thetad_6=3*a3_6*t.^2+2*a2_6*t;
thetadd_6=6*a3_6*t+2*a2_6;
subplot(row,collumn,pos1_6);
title('Vi tri khop 6');
plot(t + t0,theta_6,'.r');
grid on
hold on
subplot(row,collumn,pos2_6);
plot(t + t0,thetad_6,'.r');
title('Van toc khop 6');
hold on;
subplot(row,collumn,pos3_6);
title('Gia toc khop 6');
plot(t + t0,thetadd_6,'.r');
hold on;
end
