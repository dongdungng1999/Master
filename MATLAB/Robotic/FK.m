function P_EE = FK(the1,the2,the3,the4,the5,the6)
%% ROBOT PARAMETER

c1=cos(the1);
c2=cos(the2);c3=cos(the3);c4=cos(the4);c5=cos(the5);c6=cos(the6);
s1=sin(the1);s2=sin(the2);s3=sin(the3);s4=sin(the4);s5=sin(the5);s6=sin(the6);
c23=cos(the2+the3);s23=sin(the2+the3);
d1 = 1; d2 = 1; d3 = 1; d4 = 1; d5 = 1; d6 = 1; d7=1;
%% POSITON
x=d1*c1 + (d5+d6)*(s5*(s1*s4+c4*c1*c23)+c5*c1*s23) + (d3+d4)*c1*s23 + d7*(s6*(c4*s1-s4*c1*c23)+c6*(c5*(s1*s4+c4*c1*c23)-s5*c1*c23)) + d2*c1*c2;
y=d1*s1 - (d5+d6)*(s5*(c1*s4-c4*s1*s23)-c5*s1*s23) + (d3+d4)*s1*s23 - d7*(s6*(c4*c1+s4*s1*c23)+c6*(c5*(c1*s4-c4*s1*c23)+s5*s1*s23)) + d2*s1*c2;
z=-(d5+d6)*(c5*c23-c4*s5*s23) -(d3+d4)*c23 + d7*(c23*c6*s5-s4*s6*s23+c4*c5*c6*s23) + d2*s2;
P_EE=[x;y;z];
