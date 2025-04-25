function out = Euler(roll,pitch,yaw)
gamma = roll;
beta = pitch;
anpha = yaw;
r11 = cos(anpha)*cos(beta);
r12 = cos(anpha)*sin(beta)*sin(gamma) - sin(anpha)*cos(gamma);
r13 = cos(anpha)*sin(beta)*cos(gamma) + sin(anpha)*sin(gamma);
r21 = sin(anpha)*cos(beta);
r22 = sin(anpha)*sin(beta)*sin(gamma) + cos(anpha)*cos(gamma);
r23 = sin(anpha)*sin(beta)*cos(gamma) - cos(anpha)*sin(gamma);
r31 = -sin(beta);
r32 =  cos(beta)*sin(gamma);
r33 = cos(beta)*cos(gamma);
out = [r11 r12 r13;
       r21 r22 r23;
       r31 r32 r33];