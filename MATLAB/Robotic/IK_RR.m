function out = IK_RR(x,y,l1,l2)
the2 = acos((sqr(x) + sqr(y) - sqr(l1) - sqr(l2))/(2*l1*l2));
the1 = atan(y/x) - asin((l2*sin(the2))/sqrt(sqr(x) + sqr(y)));
the1 = rad2deg(the1);
the2 = rad2deg(the2);
out = [the1;the2];
