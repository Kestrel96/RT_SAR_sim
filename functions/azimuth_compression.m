function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution,max_range)


% dont mind this for now...
freq_kernels=1;

% Get dimensions of data array
[rows,columns]=size(SAR_range_corrected);

% Iterate through columns - every iteration is next range bin.
for k=1:columns
    
    % Get azimuth chirp from range corrected data - single column.
    azimuth_chirp=SAR_range_corrected(:,k);
    AZ_CHIRP=fft(azimuth_chirp);

    % Prepare kernel (kernels are laid out row wise)
    kernel=azimuth_LUT(k,:);
    % Window to smooth out sidelobes...
    w=hamming(length(kernel));
    w=w.';
    kernel=w.*kernel;
    KERNEL=fft(kernel);
    % In frequency domain length of vectors have to be the same, zero
    % apdding the kernel
    KERNEL=[KERNEL zeros(1,rows-length(KERNEL))];
    KERNEL=KERNEL.';

    % Calculate compressed signal
    compressed=ifft(KERNEL.*AZ_CHIRP);
    SAR_azimuth_compressed(:,k)=compressed;


    % Plot some data, 766 is sample where there is a single target.
    if k==766
        close all

        figure
        tiledlayout(2,2)
        nexttile
        plot(real(azimuth_chirp));
        title("Azimuth signal REAL")

        xlim([5000,7000])
        nexttile
        plot(imag(azimuth_chirp));
        title("Azimuth signal IMAG")
        xlim([5000,7000])
        hold on
        plot(imag(kernel));
        title("Azimuth signal IMAG")

        hold off
        nexttile
        plot(real(kernel));
        title("Reference signal REAL")
        nexttile
        plot(imag(kernel));
        title("Azimuth signal IMAG")

        figure
        tiledlayout(1,3)
        nexttile
        [c,lags] = xcorr(kernel,azimuth_chirp);
        stem(lags,abs(c))
        title("Xcorr, whole signal")
        nexttile
        [c,lags] = xcorr(real(kernel),real(azimuth_chirp));
        stem(lags,c)
        title("xcorr, real parts")
        nexttile
        [c,lags] = xcorr(imag(kernel),imag(azimuth_chirp));
        stem(lags,c)
        title("Xcorr, imag parts")
        

        figure
        tmp=conv(kernel,azimuth_chirp);
        plot(abs(tmp)/max(abs(tmp)));
        hold on
        plot(abs(compressed)/max(abs(compressed)));
        title("Convluton of kernel and azimuth chirp")
        



    end

    progress_bar(k,20,200,columns,"Azimuth compression")


end
fprintf("\n")


end

