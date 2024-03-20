cuda_shits=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifts_test.bin");
cuda_array=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/test_array.bin");
cuda_shifted=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifted.bin");

figure
imagesc(cuda_array);
figure
imagesc(abs(cuda_shifted));



 cuda_range_corrected=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_range_corrected.bin");
 imagesc(db(abs(cuda_range_corrected)))