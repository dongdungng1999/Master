function x=BASIC_TRIGONOMATRIX_FUNCTION_03(a,b,d) %a*cos(x)+b*sin(x)=d
anpha=atan2(b,a);
if(abs(d/sqrt(a*a+b*b))>1)
        x=[4*pi;4*pi;0];
else
    x1=anpha+acos(d/sqrt(a*a + b*b));
    x2=anpha-acos(d/sqrt(a*a + b*b));
        x=[x1; x2; 1];  
end