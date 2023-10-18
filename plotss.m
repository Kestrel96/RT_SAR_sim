plot_reim(compressed)
figure
tiledlayout(2,1)
nexttile
plot(real(azimuth_chirp));
hold on
plot(imag(azimuth_chirp));
nexttile
plot(real(kernel));
hold on
plot(imag(kernel));