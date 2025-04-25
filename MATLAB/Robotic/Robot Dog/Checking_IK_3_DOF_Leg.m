clear all
clc
%% DECLEARE VARIABLE
d1=1; d2=1; d3=1;
%% INPUT VALUE
X = 2
Y = 0
Z = -1
%% The 1
The1 = BASIC_TRIGONOMATRIX_FUNCTION_01(-Y, X, 0); 
the1_1 = The1(1,:);
the1_2 = The1(2,:);
c1_1 = cos(the1_1);
c1_2 = cos(the1_2);
s1_1 = sin(the1_1);
s1_2 = sin(the1_2);
%% The2
A_1 = X*c1_1 + Y*s1_1 - d1;
A_2 = X*c1_2 + Y*s1_2 - d1;
C_1 = A_1*A_1 + Z*Z + d2*d2 - d3*d3;
C_2 = A_2*A_2 + Z*Z + d2*d2 - d3*d3;
The2_1 = BASIC_TRIGONOMATRIX_FUNCTION_01(2*A_1*d2, -2*Z*d1, C_1); 
The2_2 = BASIC_TRIGONOMATRIX_FUNCTION_01(2*A_2*d2, -2*Z*d1, C_2);
the2_1 = The2_1(1,:);
the2_2 = The2_1(2,:);
the2_3 = The2_2(1,:);
the2_4 = The2_2(2,:);
c2_1 = cos(the2_1);
c2_2 = cos(the2_2);
c2_3 = cos(the2_3);
c2_4 = cos(the2_4);
s2_1 = sin(the2_1);
s2_2 = sin(the2_2);
s2_3 = sin(the2_3);
s2_4 = sin(the2_4);
%% The23
s23_1 = -(d2*s2_1 + Z)/d3;
s23_2 = -(d2*s2_2 + Z)/d3;
s23_3 = -(d2*s2_3 + Z)/d3;
s23_4 = -(d2*s2_4 + Z)/d3;
c23_1 = (A_1 - d2*c2_1)/d3;
c23_2 = (A_1 - d2*c2_2)/d3;
c23_3 = (A_2 - d2*c2_3)/d3;
c23_4 = (A_2 - d2*c2_4)/d3;
the23_1 = atan2(s23_1, c23_1);
the23_2 = atan2(s23_2, c23_2);
the23_3 = atan2(s23_3, c23_3);
the23_4 = atan2(s23_4, c23_4);
%% The3
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

the3_1 = rad2deg(the3_1);
the3_2 = rad2deg(the3_2);
the3_3 = rad2deg(the3_3);
the3_4 = rad2deg(the3_4);
%% OUT
out = [the1_1 the2_1 the3_1;
       the1_1 the2_2 the3_2;
       the1_2 the2_3 the3_3;
       the1_2 the2_4 the3_4]