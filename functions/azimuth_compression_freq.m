function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression_freq(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)
%AZIMUTH_COMPRESSION_FREQ Performs azimuth compression in frequency domain.
%   Azimuth compression is performed as filtering in frequency domain (ie. multiplication of signal and kernel).
%   Compressed signal is also shifted left by half of kernel length and padded with zeros. 
%   This function outputs SAR_azimuth_compressed matrix, that is azimuth compressed image and
%   freq_kernels that are filter kernels (of variable length) in frequency domain. First value of 
%   azimuth_LUT is length of the kernel determined by calculation of time of illumination of reference target.
%
%   range_resolution      - SAR system range resolution (used to determine LUT index to get correct reference function)
%   azimuth_LUT_resolution - resolution of azimuth_LUT
%   max_range              - maximum range taken into account. 



% Get sizes of data matrices. 
[azimuth_steps,samples]=size(SAR_range_corrected);
[reference_rows,reference_columns]=size(azimuth_LUT);

% Initialize arrays. freq_kernels are frequency domain filter kernels so they have same dimension as azimuth_LUT.
SAR_azimuth_compressed=zeros(azimuth_steps,samples);
freq_kernels=zeros(reference_rows,azimuth_steps);

% Iterate over every column of SAR_range_corrected. This way azimuth chirp is created.
% This chirp is a signal sampled at PRF.
for k=1:samples

% Determine LUT index to get the reference function.
LUT_index=floor((k*range_resoultion)/azimuth_LUT_resolution);

% NOT SURE WHY THIS IS REQUIRED, BUT RESULTS ARE BETTER
LUT_index=LUT_index-1;
if LUT_index <= 0
    LUT_index=1;
end

% The actual range compressed data are bigger than maximum range. If there are no more reference functions left rest of the data is discarded.
if LUT_index > max_range/azimuth_LUT_resolution
    break
end

% Obtain the azimuth chirp at given range/frequency.
azimuth_chirp=SAR_range_corrected(:,k)';

% Get kernel length. If for some reason the length is greater than azimuth steps clip this signal to maximum size (that is azimuth_steps).
kernel_length=azimuth_LUT(LUT_index,1);
if kernel_length > azimuth_steps
    kernel_length=azimuth_steps;
end
% Get reference chirp. Multiply by window function to smooth out sidelobes.
reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
w=blackmanharris(length(reference_chirp))';
reference_chirp=w.*reference_chirp;
% Create actual kernel. Mutliplication in frequency domain (equivalent of matched filtering by convolution in time domain)
% requires that signals are the same length. The kernel is padded with zeros.
h=[reference_chirp zeros(1,azimuth_steps-kernel_length+1)];


% Kernel and azimuth chirp are transformed to frequency domain.
H=fft(h);
freq_kernels(k,:)=H;
AZCH=fft(azimuth_chirp);

% Multiplication in frequency = convolution in time
COMPRESSED=AZCH.*H;

% Return to time domain. (This could actually be made with batch processing on GPU).
compressed=ifft(COMPRESSED);
% Filtered signal has peaks (in this case) at the end of actual azimuth chirp. That is because
% the filter "matches" best when kernel fully covers the signal (ref Cummings p. 93). To get to actual position of object the compressed signal is shifted left by
% kernel_lenght/2 samples. The part that wraps around is discarded (=0).
compressed=circshift(compressed,-floor(kernel_length/2));
compressed(end-(floor(kernel_length/2)):end)=0;

SAR_azimuth_compressed(:,k)=compressed;


    % if(k==126)
    %     LUT_index
    %     kernel_length
    %     figure
    %     nexttile
    %     plot(real(azimuth_chirp));
    %     title("chirp and h")
    %     hold on
    %     plot(real(h)+2.5);
    %     plot(abs(real(compressed))/max(abs(real(compressed))));
    %     %plot(abs(real(compressed)));

    %     legend("AZ chirp","h","compressed")
    %     hold off


    %     figure
    %     reference_chirp=azimuth_LUT(LUT_index-1,2:kernel_length);
    %     h2=[reference_chirp zeros(1,azimuth_steps-kernel_length+1)];
    %     plot(real(h2));

    %     figure
    %     reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
    %     w=blackman(length(reference_chirp))';
    %     reference_chirp=w.*reference_chirp;
    %     plot(real(reference_chirp));

    % end


 




end

