function out = inv(the1, the2, the3)
%% PARAMETERS FOR COMPUTE
syms the1 the2 the3 the4 the5 the6 d1 d2 d3 d4 d5
% the1=(0/180)*pi; 
% the2=(0/180)*pi; 
% the3=(0/180)*pi; 
% the4=(0/180)*pi;
% the5=(0/180)*pi;
% the6=(0/180)*pi;
% d1=1; d2=5; d3=3.5; d4=3.5; d5=1;  
% d1=10; d2=20; d3=0; d4=60; d5=5; 
%% DH TABLE
% DH= [ 0             0               0           the1;...
%       d1            pi/2            0           the2;...
%       d2            0               0           the3;...
%       0             pi/2            d3+d4       the4;...
%       0            -pi/2            0           the5;...
%       0             pi/2            0           the6]; 
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
T_0_3=T_0_2*T_2_3;
T_3_6 = inv(T_0_3)*T_0_6;
%% POSITION EE
T_6_EE = [1 0 0 0;...
          0 1 0 0;...
          0 0 1 0;...
          0 0 0 1];
T_0_EE = T_0_6*T_6_EE;
simplify(T_0_EE(:,4));
% T_0_EE = [sx         nx         ax     Px
%           sy         ny         ay     Py
%           sz         nz         az     Pz  
%           0         0           0     1];
% out = [T_0_EE(1,4) T_0_EE(2,4) T_0_EE(3,4) roll pitch yaw];inv

       
       

