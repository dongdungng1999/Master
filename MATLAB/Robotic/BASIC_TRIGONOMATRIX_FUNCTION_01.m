function x=BASIC_TRIGONOMATRIX_FUNCTION_01(a,b,d) %a*cos(x) + b*sin(x) = d
anpha=atan2(b,a);
if(abs(d/sqrt(a*a+b*b))>1)
        x=[4*pi;4*pi;0];
elseif (abs(d/sqrt(a*a+b*b))<1)
    x1=anpha+atan2(sqrt(a*a+b*b-d*d), d);
    x2=anpha+atan2(-sqrt(a*a+b*b-d*d), d);
        x=[x1; x2; 1];
else
    x1= 0;
    x2= pi;
        x=[x1; x2; 2];      
end