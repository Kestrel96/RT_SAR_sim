function plot_reim(signal)
%PLOT_REIM Summary of this function goes here
%   Detailed explanation goes here
figure
tiledlayout(2,1);
nexttile
plot(real(signal));
title("Real Part")
nexttile
plot(imag(signal))
title("Imag Part")



end

