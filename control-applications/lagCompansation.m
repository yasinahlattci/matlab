clc;
clear all;
Kv_h=input('Statik h�z hata katsay�s�n� giriniz :');
pay=input('A�TF G�R:');
payda=input('A�TF G�R:');
m=length(pay);
n=length(payda);
Gs=tf(pay,payda);
syms pay_m(x);
syms payda_m(x);
syms D(x);
syms Glag(s);
pay_m(x)=0;
for t=1:m
    pay_m(x)=pay_m(x)+pay(t)*x^(m-t);
end
payda_m(x)=0;
for k=1:n
    payda_m(x)=payda_m(x)+payda(k)*x^(n-k);
end
D(x)=(pay_m(x)/payda_m(x))*x;
Kv=vpa(limit(D(x)));
R=1/(1+Gs);
kutup=pole(R);
kutup
payda_baskin=input('BASKIN KUTUPLAR ���N PAYDAYI YEN�DEN G�R�N');
n_b=length(payda_baskin);
wn=sqrt(payda_baskin(n_b));
e=(payda_baskin(n_b-1)/(2*wn));
beta=ceil(Kv_h/Kv);% ceil bir �st tam say�ya yuvarl�yor
T=input('T kac olsun');
lag_n=input('PAY:');
lag_d=input('PAYDA:');
Glag=tf(lag_n,lag_d);
