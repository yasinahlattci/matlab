%NEWTON RAPHSON YÖNTEMÝ ÝLE KÖK BULMA

% x(n)= x(n)-f(n)/f'(n) þeklinde iþler
clc;
clear;
f=@(x) (x-1).^2.*(x-2).*(x-3);
df=@(x) 2.*(x-1).*(x-2).*(x-3)+(x-1).^2.*(x-2).*(x-3);
ddf=@(x) 2.*(x-2).*(x-3)+4.*(x-1).*(x-3)+4.*(x-1).*(x-2)+2.*(x-1).^2;
x0=0.5;                     
tol=1e-3;
hata=tol+1;
n=1;
while(hata>tol)
    x1=x0-df(x0)/ddf(x0);
    hata=abs(x1-x0);
    x0=x1;  
    n=n+1;
end
x1