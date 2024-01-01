%% Generate test data:
cuda_azimuth_compressed=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/azimuth_compressed.bin");
cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/range_corrected.bin");
cuda_final=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/final.bin");

azimuth_compressed=radar.SAR_azimuth_compressed;
range_corrected=RD_range_corrected;
sar_final=radar.SAR_azimuth_compressed;

%%

range_corrected_diff=sum(normalize(cuda_range_corrected)- normalize(range_corrected),"all");


close all

colormap gray
tiledlayout(1,3)
nexttile
imagesc(db(cuda_range_corrected));
title("CUDA range compressed")
nexttile
imagesc(db(cuda_azimuth_compressed));
title("CUDA azimuth compressed freq")
nexttile
imagesc(db(normalize(cuda_final)));
title("CUDA final image")


%%
figure
cuda_az_compressed=ifft(cuda_azimuth_compressed,[],1);

imagesc(db(abs(cuda_az_compressed)));

%%
%% Azimuth Compression

% radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(1000,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs,true);
[azimuth_compressed, freq_kernels] = azimuth_compression(cuda_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);

radar.SAR_azimuth_compressed=range_doppler_invert(cuda_azimuth_compressed);
display_azimuth_compressed;
