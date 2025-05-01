function f = simul_diff_proliferative(t,y)
%constant definition
a1=0.38e-1;
Cmax=1e9;
b1=1.56e-8;
n1=0.21e-7;
s=1.3e4;
r1=0.36e-7;
g=2.5e-2;
h=2.02e7;
f_n=4.12e-2;
p=1.8e-8;
j=10e-2;
k=2.02e7;
m=2e-2;
u1= 2.1e-8;

%y(1)=Cp y(2)=N y(3)=T
f(1,1)=(a1*y(1)*log(Cmax/y(1)))-(b1*y(2)*y(1))-(n1*y(3)*y(1));
f(2,1)=s+(y(2)*(g*(y(1)^2/(h+y(1)^2))))-(p*y(1)*y(2))-f_n*y(2);
f(3,1)=(r1*y(2)*y(1))+(y(3)*(j*(y(1)^2/(k+y(1)^2))))-(u1*y(1)*y(3))-m*y(3);
end