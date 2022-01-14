clc;
clear all;
ns=1500;
r=7.5;
xt=19.68;
% s adýmlamasý
s=1:-0.01:0;
% nr hesabý
nr=(ns-s*ns);
% Empedans
ze=sqrt(((r+r./s).^2)+xt^2);
% AKIM
is=220./ze;
% P alýnan
pa= (is.^2).*(r./s).*(1.-s);
% P Giriþ
pin= ((is.^2).*r)+(is.^2).*(r./s).*(1.-s);
% Mil momenti 
Tmil=pa./((2*pi.*nr)./60);
% VERÝM
verim=(pa./pin).*100;

%MOMENT-KAYMA GRAFÝÐÝ ÝÇÝN
grid on ;
hold on ;
title('MOMENT-KAYMA GRAFIGI');
xlabel('Kayma (s)');
ylabel('Moment (N/m)');
plot(s,Tmil);
axis([0 1 0 6]);
ax=gca;
ax.XDir = 'reverse';


%GÜÇ-KAYMA GRAFÝÐÝ ÝÇÝN
%grid on ;
%hold on ;
%%xlabel('Kayma (s)');
%ylabel('Guc (W)');
%plot(s,pa);
%axis([0 1 0 650]);
%ax=gca;
%ax.XDir = 'reverse';











