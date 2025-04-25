function x = Pt_bac2(a,b,c) %a*x^2+b*x + c = 0
delta = sqr(b) - 4*a*c;
if(a ~= 0)
if(delta < 0)
    x = [1;1;1];
elseif (delta == 0)
    x1 = -b/(2*a);
    x2 = -b/(2*a);
    x  = [x1; x2; 2];  
else
    x1 = (-b + sqrt(delta))/(2*a);
    x2 = (-b - sqrt(delta))/(2*a);
    x  = [x1; x2; 3];  
end
else
    x1 = -c/b;
    x = [ x1; x1; 4]; 
end