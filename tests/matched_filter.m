close all
fs=100e3;
t=0:1/fs:0.5-1/fs;
f=30;
T=0.1;
B=10;
Beta=B/T; % slope

t_full=zeros(1,fs);


%x=exp(1i*2*pi*t*f);

x=exp(1i*pi*t.^2*Beta);
signal=zeros(1,fs);

offset=20e3;
signal(offset:offset+length(x)-1)=x;

x2=x;
x2=x(end:-1:1);
x2=conj(x2);

figure
plot(real(signal))
hold on
plot(real(x2));


b=x2;

y = filter(b,1,signal);
w=hamming(1000);

figure
plot(abs(real(y)/max(y)))
hold on
plot(w)


%y=conv(signal,x2);
%y=y/max(y);

