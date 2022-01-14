clc;
clear all;
syms L f t F s ;

goster=input('Laplace için L  Ters Laplace için T yazýn:','s');
while (goster~='l' ||goster~='L'||goster~='T'||goster~='t')
    if (goster=='l' || goster=='L');
        f=input('Fonksiyonu yazýn. Deðiþken olarak t kullanýn:');
        L=laplace(f); % laplace transform
        disp('LAPLACE DÖNÜSÜMÜ')
        pretty(L)
    elseif (goster=='K' || goster=='k');
        F=input('Fonksiyonu Yazýn. Deðiþken olarak s kullanýn:');
        T=ilaplace(F); %ters laplace alma
        disp('TERS LAPLACE DÖNÜSÜMÜ')
        pretty(T)
    else
        disp('düzgün bas');
    end
end
