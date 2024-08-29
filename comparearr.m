addpath("display_scripts")
addpath("msc")
addpath("tests")
addpath("functions")


transs=read_array("/home/kuba/RT_SAR_CUDA/cuda_azimuth_compressed.bin");
nottranss = read_array("/home/kuba/RT_SAR_CUDA/build/cuda_azimuth_compressed.bin");

nottranss = nottranss.';

figure
imagesc(db(transs));
figure
imagesc(db(nottranss));
