clear all
clc
%% DECLEARE VARIABLE
d1=1; d2=1; d3=1; d4=1; d5=1; 
%% INPUT VALUE
T_0_EE = [        0.0000   -0.0000    1.0000    4.0000
    0.0000   -1.0000   -0.0000   -0.0000
    1.0000    0.0000   -0.0000    1.0000
         0         0         0    1.0000];
T_6_EE = [1 0 0 0;
          0 1 0 0;
          0 0 1 d5;
          0 0 0 1];
%% T_0_6

T_0_6 = T_0_EE*inv(T_6_EE);
%% The 1
The1 = BASIC_TRIGONOMATRIX_FUNCTION_01(T_0_6(2,4),-T_0_6(1,4),0); 
the1_1 = The1(1,:);
the1_2 = The1(2,:);
% the1_1 = atan2(T_0_EE(2,4),T_0_EE(1,4));
% the1_2 = atan2(-T_0_EE(2,4),-T_0_EE(1,4));
% the1_1 = atan2(T_0_6(2,4), T_0_6(1,4));
% the1_2 = the1_1 + pi;
% if(the1_1 > pi)
%     The1_1 = the1 - 2*pi;
% elseif(the1_1 < -pi)
%     the1_1 = the1_1 + 2*pi;
% else the1_1 = the1_1;
% end
% if(the1_2 > pi)
%     the1_2 = the1_2 - 2*pi;
% elseif(the1_2 < -pi)
%     the1_2 = the1_2 + 2*pi;
% else the1_2 = the1_2;
% end
c1_1 = cos(the1_1);
c1_2 = cos(the1_2);
s1_1 = sin(the1_1);
s1_2 = sin(the1_2);  
%% The23
A_1 = c1_1*T_0_6(1,4) + s1_1*T_0_6(2,4) - d1;
A_2 = c1_2*T_0_6(1,4) + s1_2*T_0_6(2,4) - d1;
B   = T_0_6(3,4);
d_1 = (-sqr(d2) + (sqr(A_1) + sqr(B)) + sqr(d3 + d4))/(2*(d3 + d4));
d_2 = (-sqr(d2) + (sqr(A_2) + sqr(B)) + sqr(d3 + d4))/(2*(d3 + d4));
the23_BN1 = BASIC_TRIGONOMATRIX_FUNCTION_01(-B,A_1,d_1);
the23_BN2 = BASIC_TRIGONOMATRIX_FUNCTION_01(-B,A_2,d_2);
the23_1 = the23_BN1(1,:);
the23_2 = the23_BN1(2,:);
the23_3 = the23_BN2(1,:);
the23_4 = the23_BN2(2,:);
c23_1 = cos(the23_1);
c23_2 = cos(the23_2);
c23_3 = cos(the23_3);
c23_4 = cos(the23_4);
s23_1 = sin(the23_1);
s23_2 = sin(the23_2);
s23_3 = sin(the23_3);
s23_4 = sin(the23_4);
c2_1 = (A_1  - (d3 + d4)*s23_1)/d2;
c2_2 = (A_1  - (d3 + d4)*s23_2)/d2;
c2_3 = (A_2  - (d3 + d4)*s23_3)/d2;
c2_4 = (A_2  - (d3 + d4)*s23_4)/d2;
s2_1 = (B + (d3 + d4)*c23_1)/d2;
s2_2 = (B + (d3 + d4)*c23_2)/d2;
s2_3 = (B + (d3 + d4)*c23_3)/d2;
s2_4 = (B + (d3 + d4)*c23_4)/d2;
the2_1 = atan2(s2_1, c2_1);
the2_2 = atan2(s2_2, c2_2);
the2_3 = atan2(s2_3, c2_3);
the2_4 = atan2(s2_4, c2_4);
the3_1 = the23_1 - the2_1;
the3_2 = the23_2 - the2_2;
the3_3 = the23_3 - the2_3;
the3_4 = the23_4 - the2_4;
%% RADIAN TO DEGREE
the1_1 = rad2deg(the1_1);
the1_2 = rad2deg(the1_2);

the2_1 = rad2deg(the2_1);
the2_2 = rad2deg(the2_2);
the2_3 = rad2deg(the2_3);
the2_4 = rad2deg(the2_4);
% the2_5 = rad2deg(the2_5);
% the2_6 = rad2deg(the2_6);
% the2_7 = rad2deg(the2_7);
% the2_8 = rad2deg(the2_8);

the3_1 = rad2deg(the3_1);
the3_2 = rad2deg(the3_2);
the3_3 = rad2deg(the3_3);
the3_4 = rad2deg(the3_4);
%% OUT
% out = [the1_1 the2_1 the3_1;
%        the1_1 the2_2 the3_1;
%        the1_1 the2_3 the3_2;
%        the1_1 the2_4 the3_2;
%        the1_2 the2_5 the3_3;
%        the1_2 the2_6 the3_3;
%        the1_2 the2_7 the3_4;
%        the1_2 the2_8 the3_4]

out = [the1_1 the2_1 the3_1;
       the1_1 the2_2 the3_2;
       the1_2 the2_3 the3_3;
       the1_2 the2_4 the3_4]