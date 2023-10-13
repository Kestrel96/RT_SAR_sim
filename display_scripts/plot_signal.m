function [outputArg1,outputArg2] = plot_signal(signal,spectrum_axis)
%PLOT_SIGNAL Summary of this function goes here



figure
tiledlayout(2,2);
nexttile
plot(real(signal));
title("Real Part")
nexttile
plot(imag(signal))
title("Imag Part")

nexttile
x=signal;
X=fft(x);
X=fftshift(X);
plot(spectrum_axis,abs(X));
title("Magnitude Spectrum")
nexttile
plot(spectrum_axis,imag(X));
title("Phase")




end

