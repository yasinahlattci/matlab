clc;
clear all;
ceviri_derece=57.2958;
ceviri_radyan=0.0174533;
pay = input('PAY KISMINI YAZIN:');
payda = input('PAYDA KISMINI YAZIN:');

actf_sifir=roots(pay);  %s�f�rlar� bulur
actf_kutup=roots(payda); %kutuplar� bulur

%wn_istenen=input('�STENEN Wn DE�ER�:');
%e_istenen=input ('�STENEN e DE�ER�:');
n=length(payda); %kutuplar
m=length(pay);   %s�f�rlar

k=0:(n-m-1);
reel_eksen=-((sum(actf_sifir)-sum(actf_kutup))/(n-m));
aci1=(180*(2*k+1))/(n-m);
aci2=-aci1; %asimptodlar

syms pay_m(x);
syms payda_m(x);
pay_m(x)=0;
for i=1:m;
    pay_m(x)=pay_m(x)+pay(i)*x.^(m-i);
end
payda_m(x)=0;
for i=1:n;
    payda_m(x)=payda_m(x)+payda(i)*x.^(n-i);
end
turev_payda=diff(payda_m(x));
turev_pay=diff(pay_m(x));
K(x)=-payda_m(x)/pay_m(x);
turevK=simplify(turev_payda*pay_m(x)-turev_pay*payda_m(x));
%% AYRILMA A�ISI HESAPLANACAK
ayrilma_kavusma=vpa(solve(turevK,x)); %AYRILMA KAVUSMA K�K�N�N 0 �LE REEL EKSEN ARASI KALMASI LAZIM.
h=tf(pay,payda);

rlocus(h) %%grafi�inin �izilmesi
hold on;




