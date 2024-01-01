rows=10;
columns=20;


kernels=zeros(rows,columns);
signal=zeros(rows,columns);





offset=0;
for l=1:columns
    kernels(1:end/2,l)=linspace(1,rows/2,rows/2)+1i*linspace(1,rows/2,rows/2)*0.01*l;
    kernels(end/2+1:end,l)=0.5*linspace(rows/2,1,rows/2)+1i*linspace(rows/2,1,rows/2)*0.1*l;
end

%kernels=2*ones(rows,columns)+1i*ones(rows,columns);


signal=[ones(rows/2+offset,columns)*0.5;ones(rows/2-offset,columns)];


dump_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/test_data/azc_signals.bin",signal);
dump_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/inputs/frequency_kernels_real.bin",kernels);


final=normalize(signal.*kernels);




%%
cuda_azc2=normalize(read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/azc2.bin"));
cuda_kernels=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/azc2_kernels.bin");

tiledlayout(1,2);
nexttile
imagesc(abs(final));
nexttile
imagesc(abs(cuda_azc2));
title("cuda out")

tiledlayout(1,2)
nexttile
imagesc(abs(kernels));
title("kernels")
nexttile
imagesc(abs(cuda_kernels));
title("azc2 kernels")

