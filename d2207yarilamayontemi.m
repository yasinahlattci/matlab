%YARILAMA YÖNTEMÝ ÝLE DENKLEM KÖKÜ BULMA%

clc;
clear;

f=@(x) x^2+4*x+2;  %fonksiyon olusturduk. 
%Baþka bir þekilde yeni bir script dosyasý açýp
%Function f=fnc(x) seklinde fonksiyonu olusturuyoruz.

xa=-1; %BELÝRLENEN ARALIK
xu=0;  %BELÝRLENEN ARALIK
tol=1e-2;
hata=tol+1;
n=1; %sayaç
f(xa);
f(xu);

if f(xa)*f(xu)<0   %ARALIK ÝÇÝNDE KÖKÜN VAR OLMA KOÞULU
    fprintf('\t\t\t fxa*fxy\txa\t\txu\t\txy\t hata\n');
    while (hata>tol)
    xy=(xa+xu)/2;
        if f(xy)*f(xa)<=0
            xu=xy;
        else
            xa=xy;
        end
        hata=xu-xa;
        fprintf('%d.ci adým\t',n);
        fprintf(' %5.3f\t %5.3f\t %5.3f\t %5.3f\t %5.3f\n',f(xa)*f(xy),xa,xu,xy,hata);
        n=n+1;
    end 
elseif(xa)*f(xu)>0
    disp(' bu aralýkta kök yoktur');
end
kokunuz=xy

    

%Bütün hepsini bir fonksiyon þeklinde çalýþtýrmak için
% funcion kok= yarilama(f,xa,xu,tol) Bu 4 deðeri biz gireceðiz.
    