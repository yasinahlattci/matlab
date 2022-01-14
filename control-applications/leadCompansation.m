clc;
clear all;
ceviri_derece=57.2958;
ceviri_radyan=0.0174533;
pay = input('PAY KISMINI YAZIN:'); %MUTLAKA VEKTÖR 3 ELEMANLI OLACAK.
payda = input('PAYDA KISMINI YAZIN:');%MUTLAKA VEKTÖR 3 ELEMANLI OLACAK.
wn_istenen=input('ÝSTENEN Wn DEÐERÝ:');
e_istenen=input ('ÝSTENEN e DEÐERÝ:');
actf0=roots(pay);  %sýfýrlarý bulur
actfk=roots(payda); %kutuplarý bulur
n=length(payda); %kutuplar
m=length(pay);   %sýfýrlar
%LEAD KOMPANZASYON
wn=sqrt(payda(n));
e=(payda(n-1)/(2*wn));
s1=-e_istenen*wn_istenen+1i*wn_istenen*sqrt(1-e_istenen^2);
s2=-e_istenen*wn_istenen-1i*wn_istenen*sqrt(1-e_istenen^2);
reel=real(s1);
imag=imag(s1);
s1_aci=atan(imag/reel)*ceviri_derece+180;
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
lag_aci=vpa(180-(angle(pay_m(s1)/payda_m(s1)))*ceviri_derece); % KOMPANZATÖRÜN YAPMASI GEREKEN AÇI KATKISI
at=((s1_aci-lag_aci)/2);
a0=(s1_aci-at);
at_rad=at*ceviri_radyan;
a0_rad=a0*ceviri_radyan;
x_k=reel-(imag/tan(at_rad));
x_0=reel-(imag/tan(a0_rad));
T=vpa(-1/x_0); %T Deðeri
a=vpa(-1/(x_k*T));  %a deðeri
Kc=vpa(abs(1/((s1+(1/T))/(s1+(1/(a*T)))*(pay_m(s1)/payda_m(s1))))); %Kc deðeri

%% HANGÝ DEÐERÝ GÖRMEK ÝSTÝYORSANIZ COMMAND WÝNDOW DAN ÝSMÝYLE YAZIN