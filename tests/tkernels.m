close all
kernel_length=1000;

tk=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_tkernels.bin");
% tk=tk.';

w=hamming(kernel_length);
w=w.';
for i=1:samples
   tk(i,1:kernel_length)=w.*tk(k,1:kernel_length);
end




radar_ref=radar.SAR_azimuth_reference_LUT;
index=100;

figure
tiledlayout(2,2)
nexttile
plot(real(tk(index,:)));
nexttile
plot(real(radar.SAR_azimuth_reference_LUT(index,:)));
hold on 
plot(real(tk(index,1:1000)),'x');

nexttile
plot(imag(tk(index,:)));
nexttile
plot(imag(radar.SAR_azimuth_reference_LUT(index,:)));
hold on 
plot(imag(tk(index,1:1000)),'x');



matlab_tk=[radar.SAR_azimuth_reference_LUT(index,:), zeros(1,sweeps-length(radar.SAR_azimuth_reference_LUT(index,:)))];
figure
plot(real(matlab_tk))


%%
figure
plot(real(tk(index,:)),'o');
hold on
plot(real(radar.SAR_azimuth_reference_LUT(index,:)),'x');


%%
fk=read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_fkernels.bin");
figure
plot(abs(fftshift(fft(matlab_tk))));
title("Matlab vs cuda kernel")
hold on
plot(abs(fftshift(fk(index,:))),'x');
hold on
plot(abs(fftshift(fft(tk(index,:)))),'o');
legend("Matlab","CUDA","CUDA_{windowed}")


%%
%radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(kernel_length,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs,radar.lambda,kernel_conjugate);
radar.SAR_azimuth_reference_LUT=tk;
[azimuth_compressed, freq_kernels] = azimuth_compression(radar.SAR_RD_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);

radar.SAR_azimuth_compressed=range_doppler_invert(azimuth_compressed,range_doppler_invert_shift);


for k=1:samples
    radar.SAR_azimuth_compressed(:,k)=circshift(radar.SAR_azimuth_compressed(:,k),-kernel_length/2);
    radar.SAR_azimuth_compressed(1:kernel_length/2+1,k)=0;
end

% dump_array("../RT_SAR_CUDA/data/inputs/frequency_kernels_real.bin",freq_kernels.');
% dump_array("../RT_SAR_CUDA/data/inputs/raw_data_real.bin",radar.SAR_raw_data);
%clear freq_kernels
clear radar.SAR_raw_data



display_azimuth_compressed;






%%
cuda_final = read_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/build/cuda_final.bin");
cuda_final=normalize(cuda_final);

figure
imagesc(db(cuda_final));

 %%
 % close all
 % figure
 % 
 % 
 % 
 % for i=1:length(tk)
 %     plot(real(tk(i,:)));
 %     txt=sprintf("Ref no %u",i);
 %     title(txt);
 %     hold on
 %      plot(real(radar_ref(i,:)),"x");
 %     txt=sprintf("Ref no %u",i);
 %     title(txt);
 %     hold off
 % 
 %     waitforbuttonpress
 % end
% 
% 
% %%
% for i=1:length(tk)
%     plot(real(radar_ref(i,:)));
%     txt=sprintf("Ref no %u",i);
%     title(txt);
%     drawnow
%     waitforbuttonpress
% end