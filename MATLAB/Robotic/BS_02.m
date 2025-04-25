function out = BS_02(a,b) % acosx + bsinx = 0
x1 = atan2(a,b);
x2 = x1 + pi;
out = [x1; x2]