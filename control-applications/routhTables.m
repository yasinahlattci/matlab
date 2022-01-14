%%

epsilon = 0.01;
% KATSAYI VEKTORUNU ALIR. S�TUNLARINI D�ZENLER
syms x;
coeffVector = input('input vector of your system coefficients: \n i.e. [an an-1 an-2 ... a0] = ');
coeffLength = length(coeffVector);
rhTableColumn = round(coeffLength/2);
% ROUTH TABLOSUNU SIFIR D�Z�S� �LE BA�LATIR
%rhTable = zeros(coeffLength,rhTableColumn);
% ROUTH TABLOSU �LK SIRANIN HESAPLANMASI
rhTable(1,:) = coeffVector(1:2:coeffLength);
% IKINCI SIRAYI UZUNLUGA G�RE ATAMA
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
%% ROUTH TABLOSU D��ER SIRALARIN HESAPLANMASI
% EPS�LON DE�ER� ( 0  SATIRI �C�N GEREKL�)
%  D��ER ELEMENTLER� HESAPLA
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
        pol=input('YARDIMCI POL�NOMU VEKT�R HAL�NDE G�R�N:');
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
goster = input(' S�STEM�N�ZDE B�L�NMEYEN B�R K DE�ER� VAR MI? E/H ', 's');
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
        disp('SISTEM KARARSIZDIR K �LE D�ZELT�LEMEZ')
    else
        if(rhTable(1,1)<0)
            fprintf('DAHA YAPILMADI :)))')
        else
            fprintf(' %s < K < %s  �C�N KARARLI\n',char(k_cozum1),char(k_cozum))
            disp(' DC KAZANCLAR �C�N K NIN 0 DAN K�C�K OLAMAYACAGINI UNUTMAYIN')
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
        fprintf('~~~~~> S�STEM KARARLI! <~~~~~\n')
    elseif(karar<0)
        fprintf('~~~~~> S�STEM KR�T�K KARARLI! <~~~~~\n')
    else
        fprintf('~~~~~> S�STEM KARARSIZ! <~~~~~\n')
    end                

reply = input('S�STEM�N K�KLER�N�N G�STER�LMES�N� �STER M�S�N�Z ? E/H ', 's');
if reply == 'e' || reply == 'E'
    
    fprintf('\n Verilen Polinomun K�kleri :\n')
    KOKLER
end
end