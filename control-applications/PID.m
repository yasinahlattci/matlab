clc;
clear all;
s=tf('s'); %transfer fonksiyonu tanýmla 
sys=input('fonksiyonu girin:')%1/(s^3+6*s^2+5*s); % sistem 
[y,t]=step(sys);
yp=diff(y);
ypp=diff(y,2);
t_infl=fzero(@(T) interp1(t(2:end-1),ypp,T,'linear','extrap'),0);
y_infl=interp1(t,y,t_infl,'linear');
h=mean(diff(t));
dy=gradient(y,h);
[~,idx]=max(dy); 
b=[t([idx-1,idx+1]) ones(2,1)]\y([idx-1,idx+1]);
tv=[-b(2)/b(1); (1-b(2))/b(1)];
f=[tv ones(2,1)]*b;
qr = figure('visible','off');
ylim([0 max(y)]);
hold on;
L=tv(1);
T=tv(2)-tv(1);
yontem_sec=input('Hangi yöntem kullanýlacak 1/2 ? : ');
if (yontem_sec==1)
    Kp=1.2*T/L;
    Ti=2*L;
    Td=0.5*L;
    cont=Kp*(1+(1/(Ti*s))+Td*s);
    cl_sys=feedback(cont*sys,1);
    step(sys);
    hold on;
    step(cl_sys);
else
    iste=input('routh tablosu istiyormusunuz ?','s');
    if (iste=='E' || iste=='e')
    routh_kararlilik;
    end
    %K Kazanç aralýðýnýn max deðeri Kcr oluyor
    Kcr=input('Kcr deðerini Routh Tablosundan Yazýnýz:');
    pol_kok=input('Routh tablosundaki K lý satýrýn bir üstündeki polinomu yazýn - s ile yazýn-:');
    w_cr=solve(pol_kok)
    wcr=input('Wcr osilasyon frekansýný yazýnýz -ÜSTTE BULUNDU:');
    Pcr=(2*pi)/wcr;
    Kp=0.6*Kcr;
    Ti=0.5*Pcr;
    Td=0.125*Pcr;
    cont=Kp*(1+(1/(Ti*s))+Td*s);
    syms x;
    s=tf('s');
    eq1_s=strrep(char(cont),'x','s');
    G=eval(eq1_s);
    cl_sys=feedback(G*sys,1);
    step(cl_sys);
    figure;
    step(sys)
    
    
end

%%
%pidtool(sys);
%sys1=2*sys*((6.3223*(s+1.4235)^2)/s);
%pidtool(sys1)
