function out = FK_RR(the1, the2, l1, l2)
the1 = pi*(the1/180);
the2 = pi*(the2/180);
x = l1*cos(the1) + l2*cos(the1+ the2);
y = l1*sin(the1) + l2*sin(the1+ the2);
out = [x;y];