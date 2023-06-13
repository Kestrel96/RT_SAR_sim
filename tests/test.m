close all


close all
clear
fs=10e3;
f=2e3;
f2=f/2;
t=0:1/fs:0.01-1/fs;
x=exp(1i*2*pi*f*t);
x2=exp(1i*2*pi*f2*t);
x=x+x2;
plot(real(x));

faxis=0:fs/length(t):fs-fs/length(t);
faxis=faxis-fs/2;

%% fft
X=fft(x);
X=X/length(X);
X_sh=fftshift(X);

figure
stem(faxis,real(X));
title("FFT")
xlabel("Frequency [Hz]")
ylabel("Amplitude")

X_sh_custom=fftshift_custom(X);

figure
stem(faxis,X_sh_custom);
hold on
stem(faxis,X_sh);
title("FFT")
xlabel("Frequency [Hz]")
ylabel("Amplitude")
