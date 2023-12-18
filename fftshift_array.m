
a=2000;b=150;
A=zeros(a,b);


for i=1:a
for j=1:b
    A(i,j)=i-1+j-1;
end

end

%A=A/max(A,[],"all");
figure
tiledlayout(1,3);
nexttile;
imagesc(A);
title("Raw Array")
nexttile;
imagesc(fftshift(A,2));
title("Left-Right FFTshift")
nexttile
imagesc(fftshift(A,1));
title("Up-Down FFTshift")
dump_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/test/import_data.bin",A);