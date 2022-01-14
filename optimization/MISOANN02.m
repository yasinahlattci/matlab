% MISOANN01
clear all
close all
clc

%...Veriler aliniyor
load setim XT YT
 t = XT(1:100,:);
 y = YT(1:100,:);

 %load  INPUT OUTPUT
 %t = INPUT(1:2000,:);
 %y = OUTPUT(1:2000,:);



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

FVALBEST = []; S = [];
for s = 1:10;
    top = 0;
    for i=1:10
        [xBEST,fValBEST] = MISOANN(tTra,yTra,tVal,yVal,s);
        top = top + fValBEST;
    end
    fValBEST = top/5;
    S = [S; s];
    FVALBEST = [FVALBEST, fValBEST];
    s
    fValBEST
end
stem(S,FVALBEST)
xlabel('S')
ylabel('Fval^{*}')
