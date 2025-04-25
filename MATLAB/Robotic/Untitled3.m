%% PARAMETERS
the1 = 0;
the2 = 0;
the3 = 0;
d1 = 1; 
d2 = 1;
d3 = 1;
%% DH TABLE
DH = [ 0     0       0       the1;...
       d1    -pi/2   0       the2;...
       d2    0       0       the3];
%% HORMOGENEOUS MATRIX
T_0_1=MTCDDN(DH(1,:));
T_1_2=MTCDDN(DH(2,:));
T_2_3=MTCDDN(DH(3,:));
T_3_EE = [1 0 0 d3;...
          0 1 0 0;...
          0 0 1 0;...
          0 0 0 0];
T_0_3 = T_0_1*T_1_2*T_2_3;
P_0_EE = T_0_3*T_3_EE
