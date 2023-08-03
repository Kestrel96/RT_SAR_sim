close all
clear
fs=100e3;
f=1e3;
f2=f/2;
t=0:1/fs:0.005-1/fs;
B=100e4;

x=exp(1i*2*pi*(B*t+f).*t);
h=x(end:-1:1);
h=conj(h);
h=[h,zeros(1,2000)];
x=[zeros(1,1500),x,zeros(1,500)];

y_time=filter(h,1,x);
%y_time=conv(x,h);


X=fft(x);
H=fft(h);
Y_f=X.*H;
Y_f=Y_f;

y_f=ifft(Y_f);

figure
tiledlayout(2,1)
nexttile
plot(real(x));
nexttile
plot(real(h));
plot(real(y_time),'-o');
hold on
plot(real(y_f),'--');
legend
