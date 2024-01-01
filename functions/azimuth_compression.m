function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)


% dont mind this for now...
kernel_length=length(azimuth_LUT(1,:));

% Get dimensions of data array
[rows,columns]=size(SAR_range_corrected);
freq_kernels=zeros(columns,rows);


% Iterate through columns - every iteration is next range bin.
for k=1:columns
    
    % Get azimuth chirp from range corrected data - single column.
    azimuth_chirp=SAR_range_corrected(:,k);
    AZ_CHIRP=azimuth_chirp;

    % Prepare kernel (kernels are laid out row wise)
    kernel=azimuth_LUT(k,:);
    kernel_length=length(kernel);
    % Window to smooth out sidelobes...
    w=hamming(length(kernel));
    w=w.';
    kernel=w.*kernel;
    
    % In frequency domain length of vectors have to be the same, 
    % zero padding the kernel
    h=[kernel, zeros(1,rows-length(kernel))];
    H=fft(h);
    % THIS IS NEW
    H=fftshift(H);
    %
    freq_kernels(k,:)=H;
    H=H.';
    
    
    

    % Calculate compressed signal
    % compressed=ifft(AZ_CHIRP.*H);

    compressed=AZ_CHIRP.*H;
    %compressed=circshift(compressed,-kernel_length/2);
    %compressed(1:kernel_length/2+1)=0;
    SAR_azimuth_compressed(:,k)=compressed;



    progress_bar(k,20,200,columns,"Azimuth compression")


end
fprintf("\n")


end

