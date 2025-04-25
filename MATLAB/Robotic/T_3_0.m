function out = T_3_0(the1, the2, the3, d1, d2)
c23 = cos(the2 + the3);
s23 = sin(the2 + the3);
s1 = sin(the1);
c1 = cos(the1);
s3 = sin(the3);
c3 = cos(the3);
out =[  c23*c1,  c23*s1, s23,  - d1*c23 - d2*c3
       -s23*c1, -s23*s1, c23,    d1*s23 + d2*s3
            s1,     -c1,   0,                 0
             0,       0,   0,                 1];

       
       

