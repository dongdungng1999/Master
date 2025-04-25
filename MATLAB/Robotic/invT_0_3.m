function out = invT_0_3(the1, the2, the3, d1, d2, d3, d4, d5)
%% PARAMETERS FOR COMPUTE
syms  the4 the5 the6 
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
T_0_3=T_0_1*T_1_2*T_2_3;
T_3_0=inv(T_0_3);
simplify(T_3_0);
out = simplify(T_3_0);


       
       

