clc;
clear all;
ceviri_derece=57.2958;
ceviri_radyan=0.0174533;
pay = input('PAY KISMINI YAZIN:');
payda = input('PAYDA KISMINI YAZIN:');

actf_sifir=roots(pay);  %sýfýrlarý bulur
actf_kutup=roots(payda); %kutuplarý bulur

%wn_istenen=input('ÝSTENEN Wn DEÐERÝ:');
%e_istenen=input ('ÝSTENEN e DEÐERÝ:');
n=length(payda); %kutuplar
m=length(pay);   %sýfýrlar

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
%% AYRILMA AÇISI HESAPLANACAK
ayrilma_kavusma=vpa(solve(turevK,x)); %AYRILMA KAVUSMA KÖKÜNÜN 0 ÝLE REEL EKSEN ARASI KALMASI LAZIM.
h=tf(pay,payda);

rlocus(h) %%grafiðinin çizilmesi
hold on;




