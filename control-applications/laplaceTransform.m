clc;
clear all;
syms L f t F s ;

goster=input('Laplace i�in L  Ters Laplace i�in T yaz�n:','s');
while (goster~='l' ||goster~='L'||goster~='T'||goster~='t')
    if (goster=='l' || goster=='L');
        f=input('Fonksiyonu yaz�n. De�i�ken olarak t kullan�n:');
        L=laplace(f); % laplace transform
        disp('LAPLACE D�N�S�M�')
        pretty(L)
    elseif (goster=='K' || goster=='k');
        F=input('Fonksiyonu Yaz�n. De�i�ken olarak s kullan�n:');
        T=ilaplace(F); %ters laplace alma
        disp('TERS LAPLACE D�N�S�M�')
        pretty(T)
    else
        disp('d�zg�n bas');
    end
end
