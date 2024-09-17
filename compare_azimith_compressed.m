
figure

tiledlayout(1,2)
nexttile
imagesc(db(abs(azimuth_compressed)));
title("matlab")
nexttile
cuda_azimuth_compressed=read_array("/home/kuba/RT_SAR_CUDA/build/cuda_azimuth_compressed.bin");
imagesc(db(cuda_azimuth_compressed));
title("cuda")
