function out = Quintic(theta0, thetaf,tf,step,t0,row,collumn,pos1,pos2,pos3,titlee)
%% Quy dao bac ba
%join1
a5 =   6*(thetaf-theta0)/tf^5;
a4 = -15*(thetaf-theta0)/tf^4;
a3 =  10*(thetaf-theta0)/tf^3;
%%Join1
for t  = 0: step: tf
%pause(0)
theta   = a5*t.^5 + a4*t.^4 +  a3*t.^3 + theta0;
thetad  = 5*a5*t.^4 + 4*a4*t.^3 +  3*a3*t.^2;
thetadd = 20*a5*t.^3 + 12*a4*t.^2 +  6*a3*t;
subplot(row,collumn,pos1);
if titlee == 1
title('Theta1');
elseif titlee == 2
title('Theta2');
elseif titlee == 3
title('Theta3');
elseif titlee == 4
title('Theta4');
elseif titlee == 5
title('Theta5');
else titlee == 6
title('Theta6');
end
plot(t + t0,theta,'.r');
grid on
hold on
subplot(row,collumn,pos2);
plot(t + t0,thetad,'.r');
title('Van toc');
hold on;
subplot(row,collumn,pos3);
title('Gia toc');
plot(t + t0,thetadd,'.r');
hold on;
end