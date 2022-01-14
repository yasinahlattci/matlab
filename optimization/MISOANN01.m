% MISOANN01
clear all
close all
clc

%...Veriler aliniyor
 load setim XT YT
 t = XT(1:100,:);
 y = YT(1:100,:);

% load CSTR2.mat INPUT OUTPUT
% t = INPUT(1:2000,:);
% y = OUTPUT(1:2000,:);



%----------------

N = size(t,1); % veri sayisi
R = size(t,2); % giris sayisi
% veriler karistiriliyor
%..veriler ikiye ayriliyor
II = randperm(N);
TrainingIndex = II(1:round(N/2));
ValidationIndex = II(round(N/2)+1:N);
% TrainingIndex = 1:2:N;
% ValidationIndex = 2:2:N;



tTra = t(TrainingIndex,:);
yTra = y(TrainingIndex,:);
tVal = t(ValidationIndex,:);
yVal = y(ValidationIndex,:);


S = 5;

[xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,S);
[yhatBEST] = MISOANNmodelGC(t,xBEST,S,R);

plot(TrainingIndex,yTra,'bx')
hold on
plot(ValidationIndex,yVal,'ro')
plot(yhatBEST,'k');
title(['F:',num2str(fValBEST)]);
pause(1)
