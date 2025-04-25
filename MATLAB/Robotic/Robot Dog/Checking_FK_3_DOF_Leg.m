clear all
clc
%% DECLARE VARIABLE TO COMPUTE EQUATIONS OF FORWARD KINEMATIC
% syms the1 the2 the3 the4 the5 the6 d1 d2 d3 d4 d5 d6 d7 
%% PARAMETERS FOR COMPUTE
the1 = 0 ; 
the2 = pi/2; 
the3 = -pi/2;
d1=1; 
d2=1; 
d3=1;
%% DH TABLE
DH= [ 0 0 0 the1;...
      d1 -pi/2 0 the2;...
      d2 0 0 the3];
%% HORMOGENEOUS MATRIX
T_0_1 = MTCDDN(DH(1,:))
T_1_2 = MTCDDN(DH(2,:))
T_2_3 = MTCDDN(DH(3,:))
T_0_2 = T_0_1*T_1_2;
T_0_3 = T_0_2*T_2_3
%% POSITION EE
P_3_EE = [1 0 0 d3;...
          0 1 0 0;...
          0 0 1 0;...
          0 0 0 1];
P_0_EE= T_0_3*P_3_EE
% simplify(P_0_EE)
%% PLOT ROBOT 
VR_ORG_PLT = [0  0 -1 0;...
              0 -1  0 0;...
             -1  0  0 0;...
              0 0 0 1];
A = VR_ORG_PLT*T_0_2(:,4)
B = VR_ORG_PLT*T_0_3(:,4)
C = VR_ORG_PLT*P_0_EE(:,4)

% plot3( [0; T_0_2(1,4)], [0;T_0_2(2,4)], [0;T_0_2(3,4)],'O-r',...
%        [T_0_2(1,4);T_0_3(1,4)],[T_0_2(2,4);T_0_3(2,4)],[T_0_2(3,4);T_0_3(3,4)],'O-b',...
%        [T_0_3(1,4);P_0_EE(1,4)],[T_0_3(2,4);P_0_EE(2,4)],[T_0_3(3,4);P_0_EE(3,4)],'O-g');

plot3( [0; A(1,1)], [0;A(2,1)], [0;A(3,1)],'O-r',...
       [A(1,1);B(1,1)],[A(2,1);B(2,1)],[A(3,1);B(3,1)],'O-b',...
       [B(1,1);C(1,1)],[B(2,1);C(2,1)],[B(3,1);C(3,1)],'O-g');

xlim([-10 10]); ylim([-10 10]); zlim([-10 10]); 
xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');