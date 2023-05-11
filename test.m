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
X=fftshift(X);

figure
stem(faxis,real(X));
title("FFT")
xlabel("Frequency [Hz]")
ylabel("Amplitude")

%% export dat

r=real(x);

f= fopen('./data/2_sine_signal.bin','wb');
fwrite(f,[1,length(x)],'int');
fwrite(f,real(x),'single');
fwrite(f,imag(x),'single');
fclose(f);


