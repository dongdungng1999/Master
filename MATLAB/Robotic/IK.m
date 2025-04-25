function out=IK(x,y,z)
L1 = 8.66; L2 = 13.6; L3=9.4;
% L1=1; L2=1; L3=1;

%% The1
the1 = BASIC_TRIGONOMATRIX_FUNCTION_01(-y,x,0);
n1 = x*cos(the1(1,:))+y*sin(the1(1,:))-L1*cos(pi/3);
n2 = x*cos(the1(2,:))+y*sin(the1(2,:))-L1*cos(pi/3);
%% The2
the2_1 = BASIC_TRIGONOMATRIX_FUNCTION_01(2*n1*L2,2*z*L2,n1*n1+z*z+L2*L2-L3*L3);
the2_2 = BASIC_TRIGONOMATRIX_FUNCTION_01(2*n2*L2,2*z*L2,n2*n2+z*z+L2*L2-L3*L3);
%% The3
the3_1 = atan2(z-L2*sin(the2_1(1,:)),n1-L2*cos(the2_1(1,:)))-the2_1(1,:);
the3_2 = atan2(z-L2*sin(the2_1(2,:)),n1-L2*cos(the2_1(2,:)))-the2_1(2,:);
the3_3 = atan2(z-L2*sin(the2_2(1,:)),n2-L2*cos(the2_2(1,:)))-the2_2(1,:);
the3_4 = atan2(z-L2*sin(the2_2(2,:)),n2-L2*cos(the2_2(2,:)))-the2_2(2,:);
out = [the1(1,:) the2_1(1,:) the3_1;
       the1(1,:) the2_1(2,:) the3_2;
       the1(2,:) the2_2(1,:) the3_3;
       the1(2,:) the2_2(2,:) the3_4];