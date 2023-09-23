function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)




    [rows,columns]=size(SAR_range_corrected);

    for k=  1: columns

        azimuth_chirp=SAR_range_corrected(:,k);
        AZ_CHIRP=fft(azimuth_chirp);

        kernel=azimuth_LUT(k,:);
        KERNEL=fftshift(fft(kernel));
        KERNEL=[KERNEL zeros(1,rows-length(KERNEL))];
        KERNEL=KERNEL';

        compressed=ifft(KERNEL.*AZ_CHIRP);
        SAR_azimuth_compressed(:,k)=compressed;

        

    end


end

