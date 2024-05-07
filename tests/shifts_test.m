%% axes
cuda_raxis = read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_raxis.bin");
cuda_rd_axis= read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_rd_axis.bin");



figure
tiledlayout(1,2)
nexttile
plot(cuda_raxis+params.centralSwathRange)
nexttile
plot(cuda_rd_axis)


%% shifts
cuda_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_shifts.bin");
figure
plot(cuda_shifts)

cuda_mean_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_mean_shifts.bin");
figure
plot(cuda_mean_shifts)


%%
cuda_max_vector=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_max_vector.bin");
raw_data=read_array("./raw.bin");
matlab_max_vector = max(abs(raw_data),[],2);
figure
plot(cuda_max_vector/max(cuda_max_vector));
hold on
plot(matlab_max_vector-mean(matlab_max_vector));



%%
cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_corrected.bin");

figure
imagesc(db(abs(cuda_range_corrected)))
