%% init step output
close all


cuda_max_vector=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_max_vector.bin");
raw_data=read_array("./raw.bin");
matlab_max_vector = max(abs(raw_data),[],2);
figure
plot(cuda_max_vector);
hold on
plot(matlab_max_vector);
%%
cuda_fkernels=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_fkernels.bin");
figure
plot(abs(cuda_fkernels(100,:)))

%%
cuda_tkernels=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_tkernels.bin");
figure
plot(real(cuda_tkernels(1,:)))

%%
cuda_mean_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_mean_shifts.bin");
figure
plot(cuda_mean_shifts)

%% Range compression output

cuda_range_compressed=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_compressed.bin");
max(cuda_range_compressed,[],2);
figure
imagesc(db(abs(cuda_range_compressed)))


%% Range doppler output


cuda_range_doppler=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_doppler.bin");
max(cuda_range_doppler,[],2);
figure
imagesc(db(abs(cuda_range_doppler)))

%% RCMC output

cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_corrected.bin");
figure
imagesc(db(abs(cuda_range_corrected)))



%% azimuth compression output

cuda_azimuth_compressed=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_azimuth_compressed.bin");
figure
colormap gray
mx=max(abs(cuda_azimuth_compressed),[],"all");
imagesc(db(abs(cuda_azimuth_compressed)/mx))
%imagesc(abs(cuda_azimuth_compressed))
colorbar
clim([-60,0]);

%% viewport dump
cuda_viewport=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/vport_data.bin");
figure
colormap gray
imagesc(db(cuda_viewport))
