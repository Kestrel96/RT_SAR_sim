function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression_freq(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)
%AZIMUTH_COMPRESSION_FREQ Summary of this function goes here
%   Detailed explanation goes here

% Get range sample count and azimuth steps count
% samples are columns
% azimuth steps are rows
[azimuth_steps,samples]=size(SAR_range_corrected);
[reference_rows,reference_columns]=size(azimuth_LUT);

 
SAR_azimuth_compressed=zeros(azimuth_steps,samples);
freq_kernels=zeros(reference_rows,azimuth_steps);


for k=1:samples

LUT_index=floor((k*range_resoultion)/azimuth_LUT_resolution);
LUT_index=LUT_index-1;
if LUT_index <= 0
    LUT_index=1;
end


if LUT_index > max_range/azimuth_LUT_resolution
    break
end
azimuth_chirp=SAR_range_corrected(:,k)';

kernel_length=azimuth_LUT(LUT_index,1);
if kernel_length > azimuth_steps
    kernel_length=azimuth_steps;
end
%reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
%h=[reference_chirp zeros(1,azimuth_steps-kernel_length)];
reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);

reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
w=blackmanharris(length(reference_chirp))';
reference_chirp=w.*reference_chirp;
h=[reference_chirp zeros(1,azimuth_steps-kernel_length+1)];



H=fft(h);
freq_kernels(k,:)=H;
AZCH=fft(azimuth_chirp);

COMPRESSED=AZCH.*H;

compressed=ifft(COMPRESSED);
compressed=circshift(compressed,-floor(kernel_length/2));
compressed(end-(floor(kernel_length/2)):end)=0;

SAR_azimuth_compressed(:,k)=compressed;


    if(k==126)
        LUT_index
        kernel_length
        figure
        nexttile
        plot(real(azimuth_chirp));
        title("chirp and h")
        hold on
        plot(real(h)+2.5);
        plot(abs(real(compressed))/max(abs(real(compressed))));
        %plot(abs(real(compressed)));

        legend("AZ chirp","h","compressed")
        hold off


        figure
        reference_chirp=azimuth_LUT(LUT_index-1,2:kernel_length);
        h2=[reference_chirp zeros(1,azimuth_steps-kernel_length+1)];
        plot(real(h2));

        figure
        reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
        w=blackman(length(reference_chirp))';
        reference_chirp=w.*reference_chirp;
        plot(real(reference_chirp));

    end


 




end


% %filter kernel in freq domain (H)
% %FFT of azimuth signal (FFT of rows)
% %element by element multiplication
% %IFFT of output -> this is azimuth compressed
