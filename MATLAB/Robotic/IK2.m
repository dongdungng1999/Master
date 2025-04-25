% function out = IK_Func(x,y,z,roll,pitch,yaw)
clear all
clc
% IK_Funcc = FK2_Func(0,0,0,0,0,44);
IK_Funcc = FK_Func(3,50,90,0,0,0);
x = IK_Funcc(1,1);
y = IK_Funcc(1,2);
z = IK_Funcc(1,3);
% roll = IK_Funcc(:,4);
% pitch = IK_Funcc(:,5);
% yaw = IK_Funcc(:,6);
% R_0_6 = Euler(roll,pitch,yaw);  
R11 = IK_Funcc(2,1);
R12 = IK_Funcc(2,2);
R13 = IK_Funcc(2,3);
R21 = IK_Funcc(3,1);
R22 = IK_Funcc(3,2);
R23 = IK_Funcc(3,3);
R31 = IK_Funcc(4,1);
R32 = IK_Funcc(4,2);
R33 = IK_Funcc(4,3);			
%% DECLARE 
d1=1; d2=1; d3=1; d4=1; d5=1; d6=1;
%% The1
the1 = BASIC_TRIGONOMATRIX_FUNCTION_01(y + R23*(-d5 - d6),-x - R13*(-d5 - d6),0);
the1_1 = the1(1,:);
the1_2 = the1(2,:);
% if(the1_1 > pi)
%     the1_1 = the1 - 2*pi;
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
s1_1 = sin(the1_1);
c1_2 = cos(the1_2);
s1_2 = sin(the1_2);
%% The2 
A_1 = c1_1*(x + R13*(-d5-d6)) + s1_1*(y + R23*(-d5-d6))  - d1;
A_2 = c1_2*(x + R13*(-d5-d6)) + s1_2*(y + R23*(-d5-d6))  - d1;
B = z + R33*(- d5 - d6);
the23_BN1 = BASIC_TRIGONOMATRIX_FUNCTION_01(-B,A_1,(-sqr(d2) + sqr(A_1) + sqr(B) + sqr(d3 + d4))/(2*(d3+d4)));
the23_BN2 = BASIC_TRIGONOMATRIX_FUNCTION_01(-B,A_2,(-sqr(d2) + sqr(A_2) + sqr(B) + sqr(d3 + d4))/(2*(d3+d4)));
the23_1 = the23_BN1(1,:);
the23_2 = the23_BN1(2,:);
the23_3 = the23_BN2(1,:);
the23_4 = the23_BN2(2,:);
s23_1 = sin(the23_1);
s23_2 = sin(the23_2);
s23_3 = sin(the23_3);
s23_4 = sin(the23_4);
c23_1 = cos(the23_1);
c23_2 = cos(the23_2);
c23_3 = cos(the23_3);
c23_4 = cos(the23_4);
c2_1 = (A_1 - (d3 + d4)*s23_1)/d2;
c2_2 = (A_1 - (d3 + d4)*s23_2)/d2;
c2_3 = (A_2 - (d3 + d4)*s23_3)/d2;
c2_4 = (A_2 - (d3 + d4)*s23_4)/d2;
s2_1 = (B + (d3 + d4)*c23_1)/d2;
s2_2 = (B + (d3 + d4)*c23_2)/d2;
s2_3 = (B + (d3 + d4)*c23_3)/d2;
s2_4 = (B + (d3 + d4)*c23_4)/d2;
if(abs(c2_1)>1)
    the2_1 = 4*pi;
    elseif(abs(s2_1)>1)
        the2_1 = 4*pi;
    else the2_1 = atan2(s2_1,c2_1);
        end
    
if(abs(c2_2)>1)
    the2_2 = 4*pi;
    elseif(abs(s2_2)>1)
        the2_2 = 4*pi;
    else  the2_2 = atan2(s2_2,c2_2);
        end
    
if(abs(c2_3)>1)
    the2_3 = 4*pi;
    elseif(abs(s2_3)>1)
        the2_3 = 4*pi;
    else the2_3 = atan2(s2_3,c2_3);
        end

if(abs(c2_4)>1)
    the2_4 = 4*pi;
    elseif(abs(s2_4)>1)
        the2_4 = 4*pi;
    else the2_4 = atan2(s2_4,c2_4);
        end 
% if(the2_1 > pi)
%     the2_1 = the2_1 - 2*pi;
% elseif(the2_1 < -pi)
%     the2_1 = the2_1 + 2*pi;
% else the2_1 = the2_1;
% end
% if(the2_2 > pi)
%     the2_2 = the2_2 - 2*pi;
% elseif(the2_2 < -pi)
%     the2_2 = the2_2 + 2*pi;
% else the2_2 = the2_2;
% end
% if(the2_3 > pi)
%     the2_3 = the2_3 - 2*pi;
% elseif(the2_3 < -pi)
%     the2_3 = the2_3 + 2*pi;
% else the2_3 = the2_3;
% end
% if(the2_4 > pi)
%     the2_4 = the2_4 - 2*pi;
% elseif(the2_4 < -pi)
%     the2_4 = the2_4 + 2*pi;
% else the2_4 = the2_4;
% end
%% The3
the3_1 = the23_1-the2_1;
the3_2 = the23_2-the2_2;
the3_3 = the23_3-the2_3;
the3_4 = the23_4-the2_4;
% if(the3_1 > pi)
%     the3_1 = the3_1 - 2*pi;
% elseif(the3_1 < -pi)
%     the3_1 = the3_1 + 2*pi;
% else the3_1 = the3_1;
% end
% if(the3_2 > pi)
%     the3_2 = the3_2 - 2*pi;
% elseif(the3_2 < -pi)
%     the3_2 = the3_2 + 2*pi;
% else the3_2 = the3_2;
% end
% if(the3_3 > pi)
%     the3_3 = the3_3 - 2*pi;
% elseif(the3_3 < -pi)
%     the3_3 = the3_3 + 2*pi;
% else the3_3 = the3_3;
% end
% if(the3_4 > pi)
%     the3_4 = the3_4 - 2*pi;
% elseif(the3_4 < -pi)
%     the3_4 = the3_4 + 2*pi;
% else the3_4 = the3_4;
% end
%% The4
a4_1 = s1_1*R13 - R23*c1_1;
a4_2 = s1_2*R13 - R23*c1_2;
b4_1 = -c1_1*c23_1*R13 - s1_1*c23_1*R23 - R33*s23_1;
b4_2 = -c1_1*c23_2*R13 - s1_1*c23_2*R23 - R33*s23_2;
b4_3 = -c1_2*c23_3*R13 - s1_2*c23_3*R23 - R33*s23_3;
b4_4 = -c1_2*c23_4*R13 - s1_2*c23_4*R23 - R33*s23_4;
the4_BN1 = BASIC_TRIGONOMATRIX_FUNCTION_01(a4_1,b4_1,0);
the4_BN2 = BASIC_TRIGONOMATRIX_FUNCTION_01(a4_1,b4_2,0);
the4_BN3 = BASIC_TRIGONOMATRIX_FUNCTION_01(a4_2,b4_3,0);
the4_BN4 = BASIC_TRIGONOMATRIX_FUNCTION_01(a4_2,b4_4,0);
the4_1 = the4_BN1(1,:);
the4_2 = the4_BN1(2,:);
the4_3 = the4_BN2(1,:);
the4_4 = the4_BN2(2,:);
the4_4 = the4_BN2(2,:);
the4_5 = the4_BN3(1,:);
the4_6 = the4_BN3(2,:);
the4_7 = the4_BN4(1,:);
the4_8 = the4_BN4(2,:);
% if(the4_1 > pi)
%     the4_1 = the4_1 - 2*pi;
% elseif(the4_1 < -pi)
%     the4_1 = the4_1 + 2*pi;
% else the4_1 = the4_1;
% end
% if(the4_2 > pi)
%     the4_2 = the4_2 - 2*pi;
% elseif(the4_2 < -pi)
%     the4_2 = the4_2 + 2*pi;
% else the4_2 = the4_2;
% end
% if(the4_3 > pi)
%     the4_3 = the4_3 - 2*pi;
% elseif(the4_3 < -pi)
%     the4_3 = the4_3 + 2*pi;
% else the4_3 = the4_3;
% end
% if(the4_4 > pi)
%     the4_4 = the4_4 - 2*pi;
% elseif(the4_4 < -pi)
%     the4_4 = the4_4 + 2*pi;
% else the4_4 = the4_4;
% end
% if(the4_5 > pi)
%     the4_5 = the4_5 - 2*pi;
% elseif(the4_5 < -pi)
%     the4_5 = the4_5 + 2*pi;
% else the4_5 = the4_5;
% end
% if(the4_6 > pi)
%     the4_6 = the4_6 - 2*pi;
% elseif(the4_6 < -pi)
%     the4_6 = the4_6 + 2*pi;
% else the4_6 = the4_6;
% end
% if(the4_7 > pi)
%     the4_7 = the4_7 - 2*pi;
% elseif(the4_7 < -pi)
%     the4_7 = the4_7 + 2*pi;
% else the4_7 = the4_7;
% end
% if(the4_8 > pi)
%     the4_8 = the4_8 - 2*pi;
% elseif(the4_8 < -pi)
%     the4_8 = the4_8 + 2*pi;
% else the4_8 = the4_8;
% end
%% The5
V1 = V(the1_1,the2_1,the3_1,the4_1);
V2 = V(the1_1,the2_1,the3_1,the4_2);
V3 = V(the1_1,the2_2,the3_2,the4_3);
V4 = V(the1_1,the2_2,the3_2,the4_4);
V5 = V(the1_2,the2_3,the3_3,the4_5);
V6 = V(the1_2,the2_3,the3_3,the4_6);
V7 = V(the1_2,the2_4,the3_4,the4_7);
V8 = V(the1_2,the2_4,the3_4,the4_8);

V1_11 = V1(1,1); V1_12 = V1(1,2); V1_13 = V1(1,3); V1_14 = V1(1,4);
V1_21 = V1(2,1); V1_22 = V1(2,2); V1_23 = V1(2,3); V1_24 = V1(2,4);
V1_31 = V1(3,1); V1_32 = V1(3,2); V1_33 = V1(3,3); V1_34 = V1(3,4);

V2_11 = V2(1,1); V2_12 = V2(1,2); V2_13 = V2(1,3); V2_14 = V2(1,4);
V2_21 = V2(2,1); V2_22 = V2(2,2); V2_23 = V2(2,3); V2_24 = V2(2,4);
V2_31 = V2(3,1); V2_32 = V2(3,2); V2_33 = V2(3,3); V2_34 = V2(3,4);

V3_11 = V3(1,1); V3_12 = V3(1,2); V3_13 = V3(1,3); V3_14 = V3(1,4);
V3_21 = V3(2,1); V3_22 = V3(2,2); V3_23 = V3(2,3); V3_24 = V3(2,4);
V3_31 = V3(3,1); V3_32 = V3(3,2); V3_33 = V3(3,3); V3_34 = V3(3,4);

V4_11 = V4(1,1); V4_12 = V4(1,2); V4_13 = V4(1,3); V4_14 = V4(1,4);
V4_21 = V4(2,1); V4_22 = V4(2,2); V4_23 = V4(2,3); V4_24 = V4(2,4);
V4_31 = V4(3,1); V4_32 = V4(3,2); V4_33 = V4(3,3); V4_34 = V4(3,4);

V5_11 = V5(1,1); V5_12 = V5(1,2); V5_13 = V5(1,3); V5_14 = V5(1,4);
V5_21 = V5(2,1); V5_22 = V5(2,2); V5_23 = V5(2,3); V5_24 = V5(2,4);
V5_31 = V5(3,1); V5_32 = V5(3,2); V5_33 = V5(3,3); V5_34 = V5(3,4);

V6_11 = V6(1,1); V6_12 = V6(1,2); V6_13 = V6(1,3); V6_14 = V6(1,4);
V6_21 = V6(2,1); V6_22 = V6(2,2); V6_23 = V6(2,3); V6_24 = V6(2,4);
V6_31 = V6(3,1); V6_32 = V6(3,2); V6_33 = V6(3,3); V6_34 = V6(3,4);

V7_11 = V7(1,1); V7_12 = V7(1,2); V7_13 = V7(1,3); V7_14 = V7(1,4);
V7_21 = V7(2,1); V7_22 = V7(2,2); V7_23 = V7(2,3); V7_24 = V7(2,4);
V7_31 = V7(3,1); V7_32 = V7(3,2); V7_33 = V7(3,3); V7_34 = V7(3,4);

V8_11 = V8(1,1); V8_12 = V8(1,2); V8_13 = V8(1,3); V8_14 = V8(1,4);
V8_21 = V8(2,1); V8_22 = V8(2,2); V8_23 = V8(2,3); V8_24 = V8(2,4);
V8_31 = V8(3,1); V8_32 = V8(3,2); V8_33 = V8(3,3); V8_34 = V8(3,4);

s5_1 = V1_11*R13 + V1_12*R23 + V1_13*R33;
s5_2 = V2_11*R13 + V2_12*R23 + V2_13*R33;
s5_3 = V3_11*R13 + V3_12*R23 + V3_13*R33;
s5_4 = V4_11*R13 + V4_12*R23 + V4_13*R33;
s5_5 = V5_11*R13 + V5_12*R23 + V5_13*R33;
s5_6 = V6_11*R13 + V6_12*R23 + V6_13*R33;
s5_7 = V7_11*R13 + V7_12*R23 + V7_13*R33;
s5_8 = V8_11*R13 + V8_12*R23 + V8_13*R33;

c5_1 = V1_31*R13 + V1_32*R23 + V1_33*R33;
c5_2 = V2_31*R13 + V2_32*R23 + V2_33*R33;
c5_3 = V3_31*R13 + V3_32*R23 + V3_33*R33;
c5_4 = V4_31*R13 + V4_32*R23 + V4_33*R33;
c5_5 = V5_31*R13 + V5_32*R23 + V5_33*R33;
c5_6 = V6_31*R13 + V6_32*R23 + V6_33*R33;
c5_7 = V7_31*R13 + V7_32*R23 + V7_33*R33;
c5_8 = V8_31*R13 + V8_32*R23 + V8_33*R33;

the5_1 = atan2(s5_1,c5_1);
the5_2 = atan2(s5_2,c5_2);
the5_3 = atan2(s5_3,c5_3);
the5_4 = atan2(s5_4,c5_4);
the5_5 = atan2(s5_5,c5_5);
the5_6 = atan2(s5_6,c5_6);
the5_7 = atan2(s5_7,c5_7);
the5_8 = atan2(s5_8,c5_8);
% if(the5_1 > pi)
%     the5_1 = the5_1 - 2*pi;
% elseif(the5_1 < -pi)
%     the5_1 = the5_1 + 2*pi;
% else the5_1 = the5_1;
% end
% if(the5_2 > pi)
%     the5_2 = the5_2 - 2*pi;
% elseif(the5_2 < -pi)
%     the5_2 = the5_2 + 2*pi;
% else the5_2 = the5_2;
% end
% if(the5_3 > pi)
%     the5_3 = the5_3 - 2*pi;
% elseif(the5_3 < -pi)
%     the5_3 = the5_3 + 2*pi;
% else the5_3 = the5_3;
% end
% if(the5_4 > pi)
%     the5_4 = the5_4 - 2*pi;
% elseif(the5_4 < -pi)
%     the5_4 = the5_4 + 2*pi;
% else the5_4 = the5_4;
% end
% if(the5_5 > pi)
%     the5_5 = the5_5 - 2*pi;
% elseif(the5_5 < -pi)
%     the5_5 = the5_5 + 2*pi;
% else the5_5 = the5_5;
% end
% if(the5_6 > pi)
%     the5_6 = the5_6 - 2*pi;
% elseif(the5_6 < -pi)
%     the5_6 = the5_6 + 2*pi;
% else the5_6 = the5_6;
% end
% if(the5_7 > pi)
%     the5_7 = the5_7 - 2*pi;
% elseif(the5_7 < -pi)
%     the5_7 = the5_7 + 2*pi;
% else the5_7 = the5_7;
% end
% if(the5_8 > pi)
%     the5_8 = the5_8 - 2*pi;
% elseif(the5_8 < -pi)
%     the5_8 = the5_8 + 2*pi;
% else the5_8 = the5_8;
% end
%% The6
s6_1 = V1_21*R11 + V1_22*R21 + V1_23*R31;
s6_2 = V2_21*R11 + V2_22*R21 + V2_23*R31;
s6_3 = V3_21*R11 + V3_22*R21 + V3_23*R31;
s6_4 = V4_21*R11 + V4_22*R21 + V4_23*R31;
s6_5 = V5_21*R11 + V5_22*R21 + V5_23*R31;
s6_6 = V6_21*R11 + V6_22*R21 + V6_23*R31;
s6_7 = V7_21*R11 + V7_22*R21 + V7_23*R31;
s6_8 = V8_21*R11 + V8_22*R21 + V8_23*R31;

c6_1 = V1_21*R12 + V1_22*R22 + V1_23*R32;
c6_2 = V2_21*R12 + V2_22*R22 + V2_23*R32;
c6_3 = V3_21*R12 + V3_22*R22 + V3_23*R32;
c6_4 = V4_21*R12 + V4_22*R22 + V4_23*R32;
c6_5 = V5_21*R12 + V5_22*R22 + V5_23*R32;
c6_6 = V6_21*R12 + V6_22*R22 + V6_23*R32;
c6_7 = V7_21*R12 + V7_22*R22 + V7_23*R32;
c6_8 = V8_21*R12 + V8_22*R22 + V8_23*R32;

the6_1 = atan2(s6_1,c6_1);
the6_2 = atan2(s6_2,c6_2);
the6_3 = atan2(s6_3,c6_3);
the6_4 = atan2(s6_4,c6_4);
the6_5 = atan2(s6_5,c6_5);
the6_6 = atan2(s6_6,c6_6);
the6_7 = atan2(s6_7,c6_7);
the6_8 = atan2(s6_8,c6_8);
% if(the6_1 > pi)
%     the6_1 = the6_1 - 2*pi;
% elseif(the6_1 < -pi)
%     the6_1 = the6_1 + 2*pi;
% else the6_1 = the6_1;
% end
% if(the6_2 > pi)
%     the6_2 = the6_2 - 2*pi;
% elseif(the5_2 < -pi)
%     the6_2 = the6_2 + 2*pi;
% else the6_2 = the6_2;
% end
% if(the6_3 > pi)
%     the6_3 = the6_3 - 2*pi;
% elseif(the6_3 < -pi)
%     the6_3 = the6_3 + 2*pi;
% else the6_3 = the6_3;
% end
% if(the6_4 > pi)
%     the6_4 = the6_4 - 2*pi;
% elseif(the6_4 < -pi)
%     the6_4 = the6_4 + 2*pi;
% else the6_4 = the6_4;
% end
% if(the6_5 > pi)
%     the6_5 = the6_5 - 2*pi;
% elseif(the6_5 < -pi)
%     the6_5 = the6_5 + 2*pi;
% else the6_5 = the6_5;
% end
% if(the6_6 > pi)
%     the6_6 = the6_6 - 2*pi;
% elseif(the6_6 < -pi)
%     the6_6 = the6_6 + 2*pi;
% else the6_6 = the6_6;
% end
% if(the6_7 > pi)
%     the6_7 = the6_7 - 2*pi;
% elseif(the6_7 < -pi)
%     the6_7 = the6_7 + 2*pi;
% else the6_7 = the6_7;
% end
% if(the6_8 > pi)
%     the6_8 = the6_8 - 2*pi;
% elseif(the6_8 < -pi)
%     the6_8 = the6_8 + 2*pi;
% else the6_8 = the6_8;
% end
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

out = [the1_1 the2_1 the3_1 the4_1 the5_1 the6_1;
       the1_1 the2_1 the3_1 the4_2 the5_2 the6_2;
       the1_1 the2_2 the3_2 the4_3 the5_3 the6_3;
       the1_1 the2_2 the3_2 the4_4 the5_4 the6_4;
       the1_2 the2_3 the3_3 the4_5 the5_5 the6_5;
       the1_2 the2_3 the3_3 the4_6 the5_6 the6_6;
       the1_2 the2_4 the3_4 the4_7 the5_7 the6_7;
       the1_2 the2_4 the3_4 the4_8 the5_8 the6_8]