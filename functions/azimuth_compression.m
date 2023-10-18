function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)



freq_kernels=1;
[rows,columns]=size(SAR_range_corrected);

for k=  1: columns

    azimuth_chirp=SAR_range_corrected(:,k);
    AZ_CHIRP=fftshift(fft(azimuth_chirp));

    kernel=azimuth_LUT(k,:);
    w=hamming(length(kernel));
    w=w.';
    kernel=w.*kernel;
    KERNEL=fftshift(fft(kernel));
    KERNEL=[KERNEL zeros(1,rows-length(KERNEL))];
    KERNEL=KERNEL.';
    %KERNEL=conj(KERNEL);

    compressed=ifft(KERNEL.*AZ_CHIRP);
    %compressed=KERNEL.*AZ_CHIRP;
    SAR_azimuth_compressed(:,k)=compressed;


    if k==766
        figure
        tiledlayout(2,2)
        nexttile
        plot(real(azimuth_chirp));
        nexttile
        plot(imag(azimuth_chirp));
        nexttile
        plot(real(kernel));
        nexttile
        plot(imag(kernel));


    end



end


end

