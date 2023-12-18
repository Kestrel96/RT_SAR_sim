
close all

fs=10e3;
f=5e3;
t=0:1/fs:0.01-1/fs;
samples=length(t);
x=exp(1i*2*pi*f*t);

faxis=0:fs/length(t):fs-fs/samples;

figure
plot(real(x));

X=fft(x)/length(t);

stem(abs(X));

y=exp(1i*2*pi*0.3*f+pi/2);