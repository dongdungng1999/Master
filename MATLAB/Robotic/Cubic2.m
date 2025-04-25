function out = Cubic(theta0, thetaf,tf,step,t0,row,collumn,pos1,pos2,pos3)
%% Quy dao bac ba
%join1
a3 = -2*(thetaf-theta0)/tf^3;
a2 =  3*(thetaf-theta0)/tf^2;
%%Join1
for t  = 0: step: tf
pause(0)
theta=a3*t.^3+a2*t.^2 + theta0;
thetad=3*a3*t.^2+2*a2*t;
thetadd=6*a3*t+2*a2;
subplot(row,collumn,pos1);
title('Vi tri khop 1');
plot(t + t0,theta,'.r');
grid on
hold on
subplot(row,collumn,pos2);
plot(t + t0,thetad,'.r');
title('Van toc khop 1');
hold on;
subplot(row,collumn,pos3);
title('Gia toc khop 1');
plot(t + t0,thetadd,'.r');
hold on;
end
