%YARILAMA Y�NTEM� �LE DENKLEM K�K� BULMA%

clc;
clear;

f=@(x) x^2+4*x+2;  %fonksiyon olusturduk. 
%Ba�ka bir �ekilde yeni bir script dosyas� a��p
%Function f=fnc(x) seklinde fonksiyonu olusturuyoruz.

xa=-1; %BEL�RLENEN ARALIK
xu=0;  %BEL�RLENEN ARALIK
tol=1e-2;
hata=tol+1;
n=1; %saya�
f(xa);
f(xu);

if f(xa)*f(xu)<0   %ARALIK ���NDE K�K�N VAR OLMA KO�ULU
    fprintf('\t\t\t fxa*fxy\txa\t\txu\t\txy\t hata\n');
    while (hata>tol)
    xy=(xa+xu)/2;
        if f(xy)*f(xa)<=0
            xu=xy;
        else
            xa=xy;
        end
        hata=xu-xa;
        fprintf('%d.ci ad�m\t',n);
        fprintf(' %5.3f\t %5.3f\t %5.3f\t %5.3f\t %5.3f\n',f(xa)*f(xy),xa,xu,xy,hata);
        n=n+1;
    end 
elseif(xa)*f(xu)>0
    disp(' bu aral�kta k�k yoktur');
end
kokunuz=xy

    

%B�t�n hepsini bir fonksiyon �eklinde �al��t�rmak i�in
% funcion kok= yarilama(f,xa,xu,tol) Bu 4 de�eri biz girece�iz.
    