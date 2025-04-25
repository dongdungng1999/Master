function out = FK_Func(the1, the2, the3, the4, the5, the6)
%% PARAMETERS FOR COMPUTE
the1=(the1/180)*pi; 
the2=(the2/180)*pi; 
the3=(the3/180)*pi; 
the4=(the4/180)*pi;
the5=(the5/180)*pi;
the6=(the6/180)*pi;
% d1=1; d2=1; d3=1; d4=1; d5=1; d6=1; 
% d1 = 3; d2 = 5; d3 = 4; d4 = 3; d5 = 3; 
d1=1; d2=5; d3=0; d4=7; d5=1; d6 = 1
% % DH TABLE
% DH= [ 0 0 0 the1;...
%       d1 pi/2 0 the2;...
%       d2 0 0 the3;...
%       0 pi/2 d3+d4 the4;...
%       0 -pi/2 0 the5;...
%       0 pi/2 0 the6]; 
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
P_6_EE = [1 0 0 d6;...
          0 1 0 0;...
          0 0 1 d5;...
          0 0 0 1];
P_0_EE = T_0_6*P_6_EE;
out = P_0_EE;

       
       

