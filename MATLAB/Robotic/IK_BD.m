function out = IK_BD(X, Y, Z, Roll, Pitch, Yaw, the1_pre, the2_pre,the3_pre,the4_pre,the5_pre,the6_pre)
%% DECLEARE VARIABLE
d1=1; d2=5; d3=0; d4=7; d5=1; 
%% INPUT VALUE
R_0_EE = Euler(Roll,Pitch,Yaw);
r11 = R_0_EE(1,1);
r12 = R_0_EE(1,2);
r13 = R_0_EE(1,3);
r21 = R_0_EE(2,1);
r22 = R_0_EE(2,2);
r23 = R_0_EE(2,3);
r31 = R_0_EE(3,1);
r32 = R_0_EE(3,2);
r33 = R_0_EE(3,3);
T_0_EE = [r11   r12   r13     X
          r21   r22   r23     Y
          r31   r32   r33     Z
          0     0     0       1];
T_6_EE = [1 0 0 0
          0 1 0 0
          0 0 1 d5
          0 0 0 1];
      
%% T_0_6

T_0_6 = T_0_EE*inv(T_6_EE);
%% The 1
The1 = BASIC_TRIGONOMATRIX_FUNCTION_01(T_0_6(2,4),-T_0_6(1,4),0); 
the1_1 = The1(1,:);
the1_2 = The1(2,:);
if(the1_1 > pi)
    the1_1 = the1_1 - 2*pi;
elseif(the1_1 <= -pi)
    the1_1 = the1_1 + 2*pi;
else the1_1 = the1_1;
end
if(the1_2 > pi)
    the1_2 = the1_2 - 2*pi;
elseif(the1_2 <= -pi)
    the1_2 = the1_2 + 2*pi;
else the1_2 = the1_2;
end
c1_1 = cos(the1_1);
c1_2 = cos(the1_2);
s1_1 = sin(the1_1);
s1_2 = sin(the1_2);  
%% The3
A_1 = c1_1*T_0_6(1,4) + s1_1*T_0_6(2,4)- d1;
A_2 = c1_2*T_0_6(1,4) + s1_2*T_0_6(2,4)- d1;
B   = T_0_6(3,4);
d_1 = sqr(A_1) + sqr(B) - sqr(d2) - sqr(d4) - sqr(d3);
d_2 = sqr(A_2) + sqr(B) - sqr(d2) - sqr(d4) - sqr(d3);
the3_BN1 = BASIC_TRIGONOMATRIX_FUNCTION_01(d3,d4,d_1/(2*d2));
the3_BN2 = BASIC_TRIGONOMATRIX_FUNCTION_01(d3,d4,d_2/(2*d2));
the3_1 = the3_BN1(1,:);
the3_2 = the3_BN1(2,:);
the3_3 = the3_BN2(1,:);
the3_4 = the3_BN2(2,:);
if(the3_1 > pi)
    the3_1 = the3_1 - 2*pi;
elseif(the3_1 <= -pi)
    the3_1 = the3_1 + 2*pi;
else the3_1 = the3_1;
end
if(the3_2 > pi)
    the3_2 = the3_2 - 2*pi;
elseif(the3_2 <= -pi)
    the3_2 = the3_2 + 2*pi;
else the3_2 = the3_2;
end
if(the3_3 > pi)
    the3_3 = the3_3 - 2*pi;
elseif(the3_3 <= -pi)
    the3_3 = the3_3 + 2*pi;
else the3_3 = the3_3;
end
if(the3_4 > pi)
    the3_4 = the3_4 - 2*pi;
elseif(the3_4 <= -pi)
    the3_4 = the3_4 + 2*pi;
else the3_4 = the3_4;
end
c3_1 = cos(the3_1);
c3_2 = cos(the3_2);
c3_3 = cos(the3_3);
c3_4 = cos(the3_4);
s3_1 = sin(the3_1);
s3_2 = sin(the3_2);
s3_3 = sin(the3_3);
s3_4 = sin(the3_4);
%%
K_1 = d3*c3_1 + d4*s3_1 + d2;
K_2 = d3*c3_2 + d4*s3_2 + d2;
K_3 = d3*c3_3 + d4*s3_3 + d2;
K_4 = d3*c3_4 + d4*s3_4 + d2;
H_1 = -d3*s3_1 + d4*c3_1;
H_2 = -d3*s3_2 + d4*c3_2;
H_3 = -d3*s3_3 + d4*c3_3;
H_4 = -d3*s3_4 + d4*c3_4;
s2_1 = ((A_1*H_1) + (K_1*B))/(sqr(K_1) + sqr(H_1));
s2_2 = ((A_1*H_2) + (K_2*B))/(sqr(K_2) + sqr(H_2));
s2_3 = ((A_2*H_3) + (K_3*B))/(sqr(K_3) + sqr(H_3));
s2_4 = ((A_2*H_4) + (K_4*B))/(sqr(K_4) + sqr(H_4));
c2_1 = (-B + K_1*s2_1)/H_1;
c2_2 = (-B + K_2*s2_2)/H_2;
c2_3 = (-B + K_3*s2_3)/H_3;
c2_4 = (-B + K_4*s2_4)/H_4;
the2_1 = atan2(s2_1, c2_1);
the2_2 = atan2(s2_2, c2_2);
the2_3 = atan2(s2_3, c2_3);
the2_4 = atan2(s2_4, c2_4);
if(the2_1 > pi)
    the2_1 = the2_1 - 2*pi;
elseif(the2_1 <= -pi)
    the2_1 = the2_1 + 2*pi;
else the2_1 = the2_1;
end
if(the2_2 > pi)
    the2_2 = the2_2 - 2*pi;
elseif(the2_2 <= -pi)
    the2_2 = the2_2 + 2*pi;
else the2_2 = the2_2;
end
if(the2_3 > pi)
    the2_3 = the2_3 - 2*pi;
elseif(the2_3 <= -pi)
    the2_3 = the2_3 + 2*pi;
else the2_3 = the2_3;
end
if(the2_4 > pi)
    the2_4 = the2_4 - 2*pi;
elseif(the2_4 <= -pi)
    the2_4 = the2_4 + 2*pi;
else the2_4 = the2_4;
end
c23_1 = cos(the2_1 + the3_1);
c23_2 = cos(the2_2 + the3_2);
c23_3 = cos(the2_3 + the3_3);
c23_4 = cos(the2_4 + the3_4);
s23_1 = sin(the2_1 + the3_1);
s23_2 = sin(the2_2 + the3_2);
s23_3 = sin(the2_3 + the3_3);
s23_4 = sin(the2_4 + the3_4);
%% The4
%calculation V matrix
T_3_0_1 = T_3_0(the1_1, the2_1, the3_1, d1, d2);
T_3_0_2 = T_3_0(the1_1, the2_2, the3_2, d1, d2);
T_3_0_3 = T_3_0(the1_2, the2_3, the3_3, d1, d2);
T_3_0_4 = T_3_0(the1_2, the2_4, the3_4, d1, d2);
V_1 = T_3_0_1 * T_0_6;
V_2 = T_3_0_2 * T_0_6;
V_3 = T_3_0_3 * T_0_6;
V_4 = T_3_0_4 * T_0_6;
%V13
V13_1 = V_1(1,3);
V13_2 = V_2(1,3);
V13_3 = V_3(1,3);
V13_4 = V_4(1,3);
%V33
V33_1 = V_1(3,3);
V33_2 = V_2(3,3);
V33_3 = V_3(3,3);
V33_4 = V_4(3,3);
%V23
V23_1 = V_1(2,3);
V23_2 = V_2(2,3);
V23_3 = V_3(2,3);
V23_4 = V_4(2,3);
%V11
V11_1 = V_1(1,1);
V11_2 = V_2(1,1);
V11_3 = V_3(1,1);
V11_4 = V_4(1,1);
%V31
V31_1 = V_1(3,1);
V31_2 = V_2(3,1);
V31_3 = V_3(3,1);
V31_4 = V_4(3,1);
%V12
V12_1 = V_1(1,2);
V12_2 = V_2(1,2);
V12_3 = V_3(1,2);
V12_4 = V_4(1,2);
%V32
V32_1 = V_1(3,2);
V32_2 = V_2(3,2);
V32_3 = V_3(3,2);
V32_4 = V_4(3,2);
%
the4_BN1 = BASIC_TRIGONOMATRIX_FUNCTION_01(V33_1,-V13_1,0);
the4_BN2 = BASIC_TRIGONOMATRIX_FUNCTION_01(V33_2,-V13_2,0);
the4_BN3 = BASIC_TRIGONOMATRIX_FUNCTION_01(V33_3,-V13_3,0);
the4_BN4 = BASIC_TRIGONOMATRIX_FUNCTION_01(V33_4,-V13_4,0);
the4_1 = the4_BN1(1,:);
the4_2 = the4_BN1(2,:);
the4_3 = the4_BN2(1,:);
the4_4 = the4_BN2(2,:);
the4_5 = the4_BN3(1,:);
the4_6 = the4_BN3(2,:);
the4_7 = the4_BN4(1,:);
the4_8 = the4_BN4(2,:);

if(the4_1 > pi)
    the4_1 = the4_1 - 2*pi;
elseif(the4_1 <= -pi)
    the4_1 = the4_1 + 2*pi;
else the4_1 = the4_1;
end
if(the4_2 > pi)
    the4_2 = the4_2 - 2*pi;
elseif(the4_2 <= -pi)
    the4_2 = the4_2 + 2*pi;
else the4_2 = the4_2;
end
if(the4_3 > pi)
    the4_3 = the4_3 - 2*pi;
elseif(the4_3 <= -pi)
    the4_3 = the4_3 + 2*pi;
else the4_3 = the4_3;
end
if(the4_4 > pi)
    the4_4 = the4_4 - 2*pi;
elseif(the4_4 <= -pi)
    the4_4 = the4_4 + 2*pi;
else the4_4 = the4_4;
end
if(the4_5 > pi)
    the4_5 = the4_5 - 2*pi;
elseif(the4_5 <= -pi)
    the4_5 = the4_5 + 2*pi;
else the4_5 = the4_5;
end
if(the4_6 > pi)
    the4_6 = the4_6 - 2*pi;
elseif(the4_6 <= -pi)
    the4_6 = the4_6 + 2*pi;
else the4_6 = the4_6;
end
if(the4_7 > pi)
    the4_7 = the4_7 - 2*pi;
elseif(the4_7 <= -pi)
    the4_7 = the4_7 + 2*pi;
else the4_7 = the4_7;
end
if the4_8 > pi
    the4_8 = the4_8 - 2*pi;
elseif the4_8 <= -pi
    the4_8 = the4_8 + 2*pi;
else the4_8 = the4_8;
end
c4_1 = cos(the4_1);
c4_2 = cos(the4_2);
c4_3 = cos(the4_3);
c4_4 = cos(the4_4);
c4_5 = cos(the4_5);
c4_6 = cos(the4_6);
c4_7 = cos(the4_7);
c4_8 = cos(the4_8);
s4_1 = sin(the4_1);
s4_2 = sin(the4_2);
s4_3 = sin(the4_3);
s4_4 = sin(the4_4);
s4_5 = sin(the4_5);
s4_6 = sin(the4_6);
s4_7 = sin(the4_7);
s4_8 = sin(the4_8);

%% The5
s5_1 = c4_1 * V13_1 + s4_1 * V33_1;
s5_2 = c4_2 * V13_1 + s4_2 * V33_1;
s5_3 = c4_3 * V13_2 + s4_3 * V33_2;
s5_4 = c4_4 * V13_2 + s4_4 * V33_2;
s5_5 = c4_5 * V13_3 + s4_5 * V33_3;
s5_6 = c4_6 * V13_3 + s4_6 * V33_3;
s5_7 = c4_7 * V13_4 + s4_7 * V33_4;
s5_8 = c4_8 * V13_4 + s4_8 * V33_4;
% c5
c5_1 = -V23_1;
c5_2 = -V23_2;
c5_3 = -V23_3;
c5_4 = -V23_4;
%
the5_1 = atan2(s5_1,c5_1);
the5_2 = atan2(s5_2,c5_1);
the5_3 = atan2(s5_3,c5_2);
the5_4 = atan2(s5_4,c5_2);
the5_5 = atan2(s5_5,c5_3);
the5_6 = atan2(s5_6,c5_3);
the5_7 = atan2(s5_7,c5_4);
the5_8 = atan2(s5_8,c5_4);
if(the5_1 > pi)
    the5_1 = the5_1 - 2*pi;
elseif(the5_1 <= -pi)
    the5_1 = the5_1 + 2*pi;
else the5_1 = the5_1;
end
if(the5_2 > pi)
    the5_2 = the5_2 - 2*pi;
elseif(the5_2 <= -pi)
    the5_2 = the5_2 + 2*pi;
else the5_2 = the5_2;
end
if(the5_3 > pi)
    the5_3 = the5_3 - 2*pi;
elseif(the5_3 <= -pi)
    the5_3 = the5_3 + 2*pi;
else the5_3 = the5_3;
end
if(the5_4 > pi)
    the5_4 = the5_4 - 2*pi;
elseif(the5_4 <= -pi)
    the5_4 = the5_4 + 2*pi;
else the5_4 = the5_4;
end
if(the5_5 > pi)
    the5_5 = the5_5 - 2*pi;
elseif(the5_5 <= -pi)
    the5_5 = the5_5 + 2*pi;
else the5_5 = the5_5;
end
if(the5_6 > pi)
    the5_6 = the5_6 - 2*pi;
elseif(the5_6 <= -pi)
    the5_6 = the5_6 + 2*pi;
else the5_6 = the5_6;
end
if the5_7 > pi
    the5_7 = the5_7 - 2*pi;
elseif the5_7 <= -pi
    the5_7 = the5_7 + 2*pi;
else the5_7 = the5_7;
end
if the5_8 > pi
    the5_8 = the5_8 - 2*pi;
elseif the5_8 <= -pi 
    the5_8 = the5_8 + 2*pi;
else the5_8 = the5_8;
end
%% The6
% s6
s6_1 = -s4_1 * V11_1 + c4_1 * V31_1;
s6_2 = -s4_2 * V11_1 + c4_2 * V31_1;
s6_3 = -s4_3 * V11_2 + c4_3 * V31_2;
s6_4 = -s4_4 * V11_2 + c4_4 * V31_2;
s6_5 = -s4_5 * V11_3 + c4_5 * V31_3;
s6_6 = -s4_6 * V11_3 + c4_6 * V31_3;
s6_7 = -s4_7 * V11_4 + c4_7 * V31_4;
s6_8 = -s4_8 * V11_4 + c4_8 * V31_4;
% c6
c6_1 = -s4_1 * V12_1 + c4_1 * V32_1;
c6_2 = -s4_2 * V12_1 + c4_2 * V32_1;
c6_3 = -s4_3 * V12_2 + c4_3 * V32_2;
c6_4 = -s4_4 * V12_2 + c4_4 * V32_2;
c6_5 = -s4_5 * V12_3 + c4_5 * V32_3;
c6_6 = -s4_6 * V12_3 + c4_6 * V32_3;
c6_7 = -s4_7 * V12_4 + c4_7 * V32_4;
c6_8 = -s4_8 * V12_4 + c4_8 * V32_4;
the6_1 = atan2(s6_1,c6_1);
the6_2 = atan2(s6_2,c6_2);
the6_3 = atan2(s6_3,c6_3);
the6_4 = atan2(s6_4,c6_4);
the6_5 = atan2(s6_5,c6_5);
the6_6 = atan2(s6_6,c6_6);
the6_7 = atan2(s6_7,c6_7);
the6_8 = atan2(s6_8,c6_8);
if(the6_1 > pi)
    the6_1 = the6_1 - 2*pi;
elseif the6_1 <= -pi
    the6_1 = the6_1 + 2*pi;
else the6_1 = the6_1;
end
if the6_2 > pi 
    the6_2 = the6_2 - 2*pi;
elseif the5_2 <= -pi
    the6_2 = the6_2 + 2*pi;
else the6_2 = the6_2;
end
if the6_3 > pi
    the6_3 = the6_3 - 2*pi;
elseif the6_3 <= -pi
    the6_3 = the6_3 + 2*pi;
else the6_3 = the6_3;
end
if the6_4 > pi
    the6_4 = the6_4 - 2*pi;
elseif the6_4 <= -pi
    the6_4 = the6_4 + 2*pi;
else the6_4 = the6_4;
end
if the6_5 > pi
    the6_5 = the6_5 - 2*pi;
elseif the6_5 <= -pi
    the6_5 = the6_5 + 2*pi;
else the6_5 = the6_5;
end
if the6_6 > pi
    the6_6 = the6_6 - 2*pi;
elseif the6_6 <= -pi
    the6_6 = the6_6 + 2*pi;
else the6_6 = the6_6;
end
if the6_7 > pi
    the6_7 = the6_7 - 2*pi;
elseif the6_7 <= -pi
    the6_7 = the6_7 + 2*pi;
else the6_7 = the6_7;
end
if the6_8 > pi
    the6_8 = the6_8 - 2*pi;
elseif the6_8 <= -pi
    the6_8 = the6_8 + 2*pi;
else the6_8 = the6_8;
end 
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
 
the4_1 = rad2deg(the4_1);
the4_2 = rad2deg(the4_2);
the4_3 = rad2deg(the4_3);
the4_4 = rad2deg(the4_4);
the4_5 = rad2deg(the4_5);
the4_6 = rad2deg(the4_6);
the4_7 = rad2deg(the4_7);
the4_8 = rad2deg(the4_8);
 
the5_1 = rad2deg(the5_1);
the5_2 = rad2deg(the5_2);
the5_3 = rad2deg(the5_3);
the5_4 = rad2deg(the5_4);
the5_5 = rad2deg(the5_5);
the5_6 = rad2deg(the5_6);
the5_7 = rad2deg(the5_7);
the5_8 = rad2deg(the5_8);

the6_1 = rad2deg(the6_1);
the6_2 = rad2deg(the6_2);
the6_3 = rad2deg(the6_3);
the6_4 = rad2deg(the6_4);
the6_5 = rad2deg(the6_5);
the6_6 = rad2deg(the6_6);
the6_7 = rad2deg(the6_7);
the6_8 = rad2deg(the6_8);
%% OUT
The = [the1_1 the2_1 the3_1 the4_1 the5_1 the6_1;
       the1_1 the2_1 the3_1 the4_2 the5_2 the6_2;
       the1_1 the2_2 the3_2 the4_3 the5_3 the6_3;
       the1_1 the2_2 the3_2 the4_4 the5_4 the6_4;
       the1_2 the2_3 the3_3 the4_5 the5_5 the6_5;
       the1_2 the2_3 the3_3 the4_6 the5_6 the6_6;
       the1_2 the2_4 the3_4 the4_7 the5_7 the6_7;
       the1_2 the2_4 the3_4 the4_8 the5_8 the6_8];
e1 = (The(1,1) - the1_pre)^2  + (The(1,2) - the2_pre)^2 + (The(1,3) - the3_pre)^2 + (The(1,4) - the4_pre)^2 + (The(1,5) - the5_pre)^2 + (The(1,6) - the6_pre)^2;
e2 = (The(2,1) - the1_pre)^2  + (The(2,2) - the2_pre)^2 + (The(2,3) - the3_pre)^2 + (The(2,4) - the4_pre)^2 + (The(2,5) - the5_pre)^2 + (The(2,6) - the6_pre)^2;
e3 = (The(3,1) - the1_pre)^2  + (The(3,2) - the2_pre)^2 + (The(3,3) - the3_pre)^2 + (The(3,4) - the4_pre)^2 + (The(3,5) - the5_pre)^2 + (The(3,6) - the6_pre)^2;
e4 = (The(4,1) - the1_pre)^2  + (The(4,2) - the2_pre)^2 + (The(4,3) - the3_pre)^2 + (The(4,4) - the4_pre)^2 + (The(4,5) - the5_pre)^2 + (The(4,6) - the6_pre)^2;
e5 = (The(5,1) - the1_pre)^2  + (The(5,2) - the2_pre)^2 + (The(5,3) - the3_pre)^2 + (The(5,4) - the4_pre)^2 + (The(5,5) - the5_pre)^2 + (The(5,6) - the6_pre)^2;
e6 = (The(6,1) - the1_pre)^2  + (The(6,2) - the2_pre)^2 + (The(6,3) - the3_pre)^2 + (The(6,4) - the4_pre)^2 + (The(6,5) - the5_pre)^2 + (The(6,6) - the6_pre)^2;
e7 = (The(7,1) - the1_pre)^2  + (The(7,2) - the2_pre)^2 + (The(7,3) - the3_pre)^2 + (The(7,4) - the4_pre)^2 + (The(7,5) - the5_pre)^2 + (The(7,6) - the6_pre)^2;
e8 = (The(8,1) - the1_pre)^2  + (The(8,2) - the2_pre)^2 + (The(8,3) - the3_pre)^2 + (The(8,4) - the4_pre)^2 + (The(8,5) - the5_pre)^2 + (The(8,6) - the6_pre)^2;
e = [e1 e2 e3 e4 e5 e6 e7 e8];
if e1 == min(e)
    out = [the1_1 the2_1 the3_1 the4_1 the5_1 the6_1];
elseif e2 == min(e)
    out = [the1_1 the2_1 the3_1 the4_2 the5_2 the6_2];
elseif e3 == min(e)
    out = [the1_1 the2_2 the3_2 the4_3 the5_3 the6_3];
elseif e4 == min(e)
    out = [the1_1 the2_2 the3_2 the4_4 the5_4 the6_4];
elseif e5 == min(e)
    out = [the1_2 the2_3 the3_3 the4_5 the5_5 the6_5];
elseif e6 == min(e)
    out = [the1_2 the2_3 the3_3 the4_6 the5_6 the6_6]; 
elseif e7 == min(e)
    out = [the1_2 the2_4 the3_4 the4_7 the5_7 the6_7];
else e8 == min(e)
    out = [the1_2 the2_4 the3_4 the4_8 the5_8 the6_8];
end

