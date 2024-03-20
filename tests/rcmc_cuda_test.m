clear
close all
sweeps=1000;
samples=sweeps;
raxis=linspace(-500,500,1000);
rd_axis=linspace(-500,500,sweeps);
fs=10;
lambda=0.03;
v=30;
Alfa=1000000;
c=3e8;

delta_R=r_shift(rd_axis,raxis,lambda,v);


R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

shifts=zeros(sweeps,1);
shifts2=zeros(sweeps,1);
for k=1:sweeps
    shifts2(k,1)=mean(delta_samples(k,:));
    shifts(k,1)=floor(mean(delta_samples(k,:)));
end


delta_S=delta_s(rd_axis,raxis,lambda,v,Alfa,samples,fs,c);

figure
plot(shifts,"x")
hold on
plot(shifts2)
plot(delta_S,'+')
legend("shifts","shifts2","delta_S")


%% load from CUDA

cuda_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifts_cuda.bin");

figure
plot(shifts,"--")
hold on
plot(cuda_shifts)
plot(delta_S,'+')
legend("shifts","shifts_{cuda}","shifts_{matlab}")


%%

cuda_shifts=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/shifts_cuda.bin");

figure
plot(cuda_shifts)
hold on
plot(delta_samples)
legend("cuda", "matlab")

