function out = flotrobot(the1, the2, the3, the4, the5, the6, d1, d2, d3, d4, d5, d6)
the1=(the1/180)*pi; 
the2=(the2/180)*pi; 
the3=(the3/180)*pi; 
the4=(the4/180)*pi;
the5=(the5/180)*pi;
the6=(the6/180)*pi;
%% DH TABLE
DH= [ 0     0       0       the1;...
      d1    pi/2    0       the2;...
      d2    0       0       the3;...
      d3    pi/2    d4      the4;...
      0     -pi/2   0       the5;...
      0     pi/2    0       the6]; 
%% HORMOGENEOUS MATRIX
T_0_1=MTCDDN(DH(1,:));
T_1_2=MTCDDN(DH(2,:));
T_2_3=MTCDDN(DH(3,:));
T_3_4=MTCDDN(DH(4,:));
T_4_5=MTCDDN(DH(5,:));
T_5_6=MTCDDN(DH(6,:));
T_0_2=T_0_1*T_1_2;
T_0_3=T_0_2*T_2_3;
T_0_4=T_0_3*T_3_4;
T_0_5=T_0_4*T_4_5;
T_0_6=T_0_5*T_5_6;
%% POSITION EE
P_3_EE_3=T_0_3*[d3;0;0;1];
P_5_EE_5=T_0_5*[0;0;0;1];
P_0_EE = T_0_6*[0;0;d5;1];
P_0_EE_2 = T_0_6*[d6;0;d5;1];
% simplify(P_0_EE)
%% PLOT ROBOT 

out = plot3([0; T_0_2(1,4)],[0;T_0_2(2,4)],[-2;T_0_2(3,4)],'O-r',...
     [T_0_2(1,4);T_0_3(1,4)],[T_0_2(2,4);T_0_3(2,4)],[T_0_2(3,4);T_0_3(3,4)],'O-b',...
     [T_0_3(1,4);P_3_EE_3(1,1)],[T_0_3(2,4);P_3_EE_3(2,1)],[T_0_3(3,4);P_3_EE_3(3,1)],'O-y',...
     [P_3_EE_3(1,1);T_0_4(1,4)],[P_3_EE_3(2,1);T_0_4(2,4)],[P_3_EE_3(3,1);T_0_4(3,4)],'O-k',...
     [T_0_4(1,4);P_0_EE(1,1)],[T_0_4(2,4);P_0_EE(2,1)],[T_0_4(3,4);P_0_EE(3,1)],'O-m',...
     [P_0_EE(1,1);P_0_EE_2(1,1)],[P_0_EE(2,1);P_0_EE_2(2,1)],[P_0_EE(3,1);P_0_EE_2(3,1)],'O-m','linewidth',1);
xlim([-15 15]); ylim([-15 15]); zlim([-15 15]); 
xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');
