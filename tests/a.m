cuda_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifts_test.bin");
cuda_array=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/test_array.bin");
cuda_shifted=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifted.bin");
pre_shift=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/pre_shift_array.bin");


figure
tiledlayout(1,3)
nexttile
plot(cuda_shifts);
title("CUDA SHIFTS")
nexttile
imagesc(abs(pre_shift));
title("pre shift")
nexttile
imagesc(abs(cuda_shifted));
title("SHIFTED")


%%
 cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_corrected.bin");
 imagesc(db(abs(cuda_range_corrected)))


 %% 

 cuda_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_shifts.bin");
 figure
 plot(cuda_shifts);
