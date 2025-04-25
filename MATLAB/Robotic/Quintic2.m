function out = Quintic(theta1,theta2,theta3,theta4,theta5, theta6, theta1f, theta2f, theta3f, theta4f, theta5f, theta6f,tf,step)
%% Quy dao bac ba
d1=1; d2=5; d3=0; d4=7; d5=1; d6 = 1;
%join1f
a5_1 =   6*(theta1f-theta1)/tf^5;
a4_1 = -15*(theta1f-theta1)/tf^4;
a3_1 =  10*(theta1f-theta1)/tf^3;

a5_2 =   6*(theta2f-theta2)/tf^5;
a4_2 = -15*(theta2f-theta2)/tf^4;
a3_2 =  10*(theta2f-theta2)/tf^3;

a5_3 =   6*(theta3f-theta3)/tf^5;
a4_3 = -15*(theta3f-theta3)/tf^4;
a3_3 =  10*(theta3f-theta3)/tf^3;

a5_4 =   6*(theta4f-theta4)/tf^5;
a4_4 = -15*(theta4f-theta4)/tf^4;
a3_4 =  10*(theta4f-theta4)/tf^3;

a5_5 =   6*(theta5f-theta5)/tf^5;
a4_5 = -15*(theta5f-theta5)/tf^4;
a3_5 =  10*(theta5f-theta5)/tf^3;

a5_6 =   6*(theta6f-theta6)/tf^5;
a4_6 = -15*(theta6f-theta6)/tf^4;
a3_6 =  10*(theta6f-theta6)/tf^3;

%%Join1
for t  = 0: step: tf
pause(0)
theta1ff   = a5_1*t.^5 + a4_1*t.^4 +  a3_1*t.^3 + theta1;
theta2ff   = a5_2*t.^5 + a4_2*t.^4 +  a3_2*t.^3 + theta2;
theta3ff   = a5_3*t.^5 + a4_3*t.^4 +  a3_3*t.^3 + theta3;
theta4ff   = a5_4*t.^5 + a4_4*t.^4 +  a3_4*t.^3 + theta4;
theta5ff   = a5_5*t.^5 + a4_5*t.^4 +  a3_5*t.^3 + theta5;
theta6ff  = a5_6*t.^5 + a4_6*t.^4 +  a3_6*t.^3 + theta6;
flotrobot(theta1ff, theta2ff, theta3ff, theta4ff, theta5ff, theta6ff, d1, d2, d3, d4, d5,d6);
end