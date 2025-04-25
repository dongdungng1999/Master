function out = FK2_Func(the1, the2, the3, the4, the5, the6)

%% PARAMETERS FOR COMPUTE
% the1=(0/180)*pi; 
% the2=(0/180)*pi; 
% the3=(0/180)*pi; 
% the4=(0/180)*pi;
% the5=(0/180)*pi;
% the6=(0/180)*pi;
% d1=1; d2=5; d3=3.5; d4=3.5; d5=1;  
% d1=10; d2=20; d3=0; d4=60; d5=5; 
d1=1; d2=5; d3=0; d4=7; d5=1; 
the1=(the1/180)*pi; 
the2=(the2/180)*pi; 
the3=(the3/180)*pi; 
the4=(the4/180)*pi;
the5=(the5/180)*pi;
the6=(the6/180)*pi;
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
T_0_2=T_0_1*T_1_2;
T_0_3=T_0_2*T_2_3;
T_0_4=T_0_3*T_3_4;
T_0_5=T_0_4*T_4_5;
T_0_6=T_0_5*T_5_6;
T_6_EE = [1 0 0 0;...
          0 1 0 0;...
          0 0 1 d5;...
          0 0 0 1];
T_0_EE = T_0_6*T_6_EE;
r11 = T_0_EE(1,1);
r12 = T_0_EE(1,2);
r21 = T_0_EE(2,1);
r22 = T_0_EE(2,2);
r31 = T_0_EE(3,1);
r32 = T_0_EE(3,2);
r33 = T_0_EE(3,3);
if(sqrt(sqr(r11) + sqr(r21)) == 0)
    if(r31 < 0)
        pitch = pi/2;
        yaw = 0;
        roll = atan2(r12,r22);
    else(r31 > 0)
        pitch = -pi/2;
        yaw = 0;
        roll = atan2(-r12,r22);
    end
else 
pitch = atan2(-r31, sqrt(sqr(r11) + sqr(r21)));
yaw = atan2((r21/cos(pitch)),(r11/cos(pitch)));
roll = atan2((r32/cos(pitch)),(r33/cos(pitch)));    
end
%% POSITION EE

% simplify(T_0_EE(:,4))
% T_0_EE = [sx         nx         ax     Px
%           sy         ny         ay     Py
%           sz         nz         az     Pz  
%           0         0           0     1];
out = [T_0_EE(1,4) T_0_EE(2,4) T_0_EE(3,4) roll pitch yaw];

       
       

