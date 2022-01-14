%%

epsilon = 0.01;
% KATSAYI VEKTORUNU ALIR. SÜTUNLARINI DÜZENLER
syms x;
coeffVector = input('input vector of your system coefficients: \n i.e. [an an-1 an-2 ... a0] = ');
coeffLength = length(coeffVector);
rhTableColumn = round(coeffLength/2);
% ROUTH TABLOSUNU SIFIR DÝZÝSÝ ÝLE BAÞLATIR
%rhTable = zeros(coeffLength,rhTableColumn);
% ROUTH TABLOSU ÝLK SIRANIN HESAPLANMASI
rhTable(1,:) = coeffVector(1:2:coeffLength);
% IKINCI SIRAYI UZUNLUGA GÖRE ATAMA
if (rem(coeffLength,2) ~= 0)  
    rhTable(2,1:rhTableColumn - 1) = coeffVector(1,2:2:coeffLength);
else
    rhTable(2,:) = coeffVector(1,2:2:coeffLength);
end
for i=1:2
    if (rhTable(i,1) == 0)
        rhTable(i,1) = epsilon;
    end
end
%% ROUTH TABLOSU DÝÐER SIRALARIN HESAPLANMASI
% EPSÝLON DEÐERÝ ( 0  SATIRI ÝCÝN GEREKLÝ)
%  DÝÐER ELEMENTLERÝ HESAPLA
syms s;
for i = 3:coeffLength
   
    %  special case: row of all zeros
    if rhTable(i-1,:) == 0
        order = (coeffLength - i);
        cnt1 = 0;
        cnt2 = 1;
        for j = 1:rhTableColumn - 1
            rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
            cnt2 = cnt2 + 1;
            cnt1 = cnt1 + 2;
        end
    end
    for j = 1:rhTableColumn - 1
        %  first element of upper row
        firstElemUpperRow = rhTable(i-1,1);
        
        %  compute each element of the table
        rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - ....
            (rhTable(i-2,1) * rhTable(i-1,j+1))) / firstElemUpperRow;  
    end

    if(sum(rhTable(i,:))==0&&rhTable(i,1)==0&&rhTable(i,2)==0)
        yardimci_pol=0;
        g=1;
            for t=coeffLength-i+1:-2:0
                yardimci_pol=yardimci_pol+rhTable(i-1,g)*s^(t);
                g=g+1;
            end
        
        YARDIMCI_POLINOM=diff(yardimci_pol,s)
        pol=input('YARDIMCI POLÝNOMU VEKTÖR HALÝNDE GÝRÝN:');
        for bt=1:(rhTableColumn-1)
            rhTable(i,bt)=pol(bt);
        end   
    end
    if(rhTable(i,1)==0)
        rhTable(i,1)=epsilon;
    end
end
rhTable(coeffLength,1)=coeffVector(coeffLength);
%%  SONUCLARIN BULUNMASI
goster = input(' SÝSTEMÝNÝZDE BÝLÝNMEYEN BÝR K DEÐERÝ VAR MI? E/H ', 's');
if goster=='e'||goster=='E';
    rhTable
    sc=size(rhTable);
    row=sc(1)-1;
    carp=1;
    degisim=0;
    for t=1:(row-2)
        if (rhTable(t,1)*rhTable(t+1,1))<0
            degisim=degisim+1;
        end 
    end
    for i=1:row
        carp=+carp*rhTable(i,1);     
    end
    k_cozum=solve(carp,x);
    k_cozum1=solve(rhTable(sc(1),1),x);
    if (degisim~=0)
        disp('SISTEM KARARSIZDIR K ÝLE DÜZELTÝLEMEZ')
    else
        if(rhTable(1,1)<0)
            fprintf('DAHA YAPILMADI :)))')
        else
            fprintf(' %s < K < %s  ÝCÝN KARARLI\n',char(k_cozum1),char(k_cozum))
            disp(' DC KAZANCLAR ÝCÝN K NIN 0 DAN KÜCÜK OLAMAYACAGINI UNUTMAYIN')
        end 
    end
else
    fprintf('\n Routh Tablosu:\n')
    rhTable
    KOKLER = roots(coeffVector);
    karar=0;
    for r=1:coeffLength-1
        if (real(KOKLER(r))>epsilon)
            karar=99;
        elseif (real(KOKLER(r))<-epsilon||real(KOKLER(r))<epsilon&&imag(KOKLER(r))~=0)
            karar=karar-1;
        else
            karar=karar+0;
        end
    end
    if(karar==0)
        fprintf('~~~~~> SÝSTEM KARARLI! <~~~~~\n')
    elseif(karar<0)
        fprintf('~~~~~> SÝSTEM KRÝTÝK KARARLI! <~~~~~\n')
    else
        fprintf('~~~~~> SÝSTEM KARARSIZ! <~~~~~\n')
    end                

reply = input('SÝSTEMÝN KÖKLERÝNÝN GÖSTERÝLMESÝNÝ ÝSTER MÝSÝNÝZ ? E/H ', 's');
if reply == 'e' || reply == 'E'
    
    fprintf('\n Verilen Polinomun Kökleri :\n')
    KOKLER
end
end