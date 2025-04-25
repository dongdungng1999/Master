clear all
clc
%% DECLARE VARIABLE TO COMPUTE EQUATIONS OF FORWARD KINEMATIC
syms the1 the2 the3
syms d1 d2 d3
%% DH TABLE
DH= [ 0 0 0 the1;...
      d1 -pi/2 0 the2;...
      d2 0 0 the3];
%% HORMOGENEOUS MATRIX
T_0_1 = MTCDDN(DH(1,:))
T_1_2 = MTCDDN(DH(2,:))
T_2_3 = MTCDDN(DH(3,:))
T_0_2 = T_0_1*T_1_2;
T_0_3 = T_0_2*T_2_3;
%% POSITION EE
P_3_EE = [1 0 0 d3;...
          0 1 0 0;...
          0 0 1 0;...
          0 0 0 1];
P_0_EE= T_0_3*P_3_EE;
simplify(P_0_EE)