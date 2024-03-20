tk=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/tkernels.bin");

figure
tiledlayout(1,2)
nexttile
plot(real(tk(1,:)));
nexttile
plot(real(radar.SAR_azimuth_reference_LUT(1,:);
