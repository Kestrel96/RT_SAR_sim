%% Generate test data:
cuda_azimuth_compressed=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/azimuth_compressed.bin");
cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/range_corrected.bin");
cuda_final=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/final.bin");

azimuth_compressed=radar.SAR_azimuth_compressed;
range_corrected=radar.SAR_RD_range_corrected;
sar_final=radar.SAR_azimuth_compressed;

%%

range_corrected_diff=sum(normalize(cuda_range_corrected)- normalize(range_corrected),"all");


close all

colormap gray
tiledlayout(1,3)
nexttile
imagesc(db(cuda_range_corrected));
title("CUDA range corrected")
nexttile
imagesc(db(cuda_azimuth_compressed));
title("CUDA azimuth compressed freq")
nexttile
imagesc(dbn((cuda_final)));
clim([-50 0])
title("CUDA final image")


%%
% figure
% cuda_az_compressed=fftshift(cuda_az_compressed,1);
% cuda_az_compressed=ifft(cuda_azimuth_compressed,[],1);
%
% imagesc(db(abs(cuda_az_compressed)));




%% Azimuth Compression

radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(1000,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs,true);
[azimuth_compressed, freq_kernels] = azimuth_compression(cuda_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);
tiledlayout(1,2)
nexttile
imagesc(abs(azimuth_compressed));
title("azimuth compressed from cuda data")
nexttile
imagesc(abs(cuda_azimuth_compressed));
title("azimuth compressed on GPU")


real_diff=max(normalize(real(cuda_azimuth_compressed(:,10)))-normalize(real(azimuth_compressed(:,10))));
imag_diff=max(normalize(imag(cuda_azimuth_compressed(:,10)))-normalize(imag(azimuth_compressed(:,10))));

%%
radar.SAR_azimuth_compressed=range_doppler_invert(cuda_azimuth_compressed);
display_azimuth_compressed;

%%
close all

cuda_final=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/final.bin");
cuda_vs_matlab_figure=figure('Name','Cuda Matlab Comparison','NumberTitle','off','Position', [0 0 1600 900]);

colormap gray
tiledlayout(1,2)
nexttile
imagesc(raxis,azimuth_axis,dbn((radar.SAR_azimuth_compressed)));
clim([-50 0])
title("MATLAB Final Image")
cb=colorbar();
ylabel(cb,"Power (db)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
ax = gca;
ax.YDir= 'normal';

nexttile
imagesc(raxis,azimuth_axis,dbn((cuda_final)));
clim([-50 0])
title("CUDA Final Image")
cb=colorbar();
ylabel(cb,"Power (db)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
ax = gca;
ax.YDir= 'normal';

saveas(cuda_vs_matlab_figure,"./graphics/cuda_vs_matlab.png");
saveas(cuda_vs_matlab_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/cuda_vs_matlab.png");

