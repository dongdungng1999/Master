tf = 5;
pi = [2;0];
pf = [0.5;1.866];
a3 = -2/tf.^3;
a2 =  3/tf.^2;
t = 0:0.1:tf;
s = a3*t.^3 + a2*t.2;
pe = pi + s*(pf - pi);
pe_dot = 3*a3*t.^2; + 2*a2*t;
pe_dot_dot = 6*a3*t + 2*a2;
subplot(3,1,1);
plot(t,pe);
grid on
hold on
subplot(3,1,2);
plot(t,pe_dot,'.r');
title('Quy dao bac ba');
hold on;
subplot(3,1,3);
plot(t,pe_dot_dot,'.r');