function [xy,fxy] = yarilama(f,xa,xu,Nmax,epsilon)
hata=0.1;
n=1;
xy=0;

if f(xa)*f(xu)<0
    while (hata>epsilon && n<=Nmax)
        xy(n)=(xa+xu)/2;
        fxy(n)=f(xy(n));
        fxa=f(xa);
        fxu=f(xu);
        if fxy(n)*fxa<=0
            xu=xy(n);
        else
            xa=xy(n);
        end
        hata =abs(xa-xu)/2;
        n=n+1;
    end
elseif f(xa)*f(xu)>0
    disp ('Bu aralikta kök yok');
else
    if fxa==0
        xy=xa;
    else
        xy=xu;
    end
end
end

        