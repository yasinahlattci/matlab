%GOLDEN SECTÝON ARAMA YÖNTEMÝ

f=@(x) (x-1).^2.*(x-2).*(x-3);

a=1.5;
b=2;
epsilon=1e-6;
Nmax=50;
tau=(sqrt(5)-1)/2; %ALTIN ORAN
k=0;

x1=a+(1-tau)*(b-a);
x2=a+tau*(b-a);
f_x1=f(x1);
f_x2=f(x2);
figure;hold on
plot(x1,f_x1,'ro');
plot(x2,f_x2,'bs');
drawnow
while((abs(b-a)>epsilon)&& (k<Nmax))
    k=k+1;
    if (f_x1<f_x2)
        b=x2;
        x2=x1;
        x1=a+(1-tau)*(b-a);
        f_x1=f(x1);
        f_x1=f(x2);
        plot(x1,f_x1,'ro');
    else
        a=x1;
        x1=x2;
        x2=a+tau*(b-a);
        f_x1=f(x1);
        f_x2=f(x2);
        plot(x2,f_x2,'bs');
    end
    drawnow
end
a
b
x1
x2
