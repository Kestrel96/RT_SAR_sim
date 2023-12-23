%% azimuth_compression 

close all
rows=10;
columns=10;
signals=zeros(rows,columns);
kernels=zeros(rows,columns);
out=zeros(rows,columns);


for i=1:columns
    signals(:,i)=linspace(0,columns-1,columns);    
end


for i=1:rows
kernels(i,:)=linspace(0,rows-1,rows); 
end


for i=1:columns
out(:,i)=signals(:,i).*kernels(:,i);
end

figure
tiledlayout(3,1)
nexttile
imagesc(signals)
title("signals")
nexttile
imagesc(kernels)
title("kernels")
nexttile
imagesc(out)
title("out")


dump_array("../RT_SAR_CUDA/test_data/azc_signals.bin",signals);
dump_array("../RT_SAR_CUDA/test_data/azc_kernels.bin",kernels);


%% complex test data read
close all
rows=150;
columns=200;
tmp_shift=3;
signals=zeros(rows,columns);
kernels=zeros(rows,columns);
out=zeros(rows,columns);


for i=1:rows
    signals(i,:)=linspace(0,columns-1,columns)+tmp_shift+1i*(linspace(0,columns-1,columns)+tmp_shift);    
end

imagesc(abs(signals));
dump_array("../RT_SAR_CUDA/test_data/complex_array.bin",signals);








%%  Read array
close all
data = read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/complex_signals.bin");
sum(data-signals,"all")
imagesc(abs(data));
%%
data = read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/outputs/final.bin");

colormap gray
data=normalize(data);
imagesc(db(abs(data)));