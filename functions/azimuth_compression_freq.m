function [SAR_azimuth_compressed, freq_kernels] = azimuth_compression_freq(SAR_range_corrected,azimuth_LUT,range_resoultion,azimuth_LUT_resolution)
%AZIMUTH_COMPRESSION_FREQ Summary of this function goes here
%   Detailed explanation goes here

% Get range sample count and azimuth steps count
% samples are columns
% azimuth steps are rows
[azimuth_steps,samples]=size(SAR_range_corrected);


for k=1:526

LUT_index=floor((k*range_resoultion)/azimuth_LUT_resolution);
azimuth_chirp=SAR_range_corrected(:,k)';

kernel_length=azimuth_LUT(LUT_index,1);
%reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);
%h=[reference_chirp zeros(1,azimuth_steps-kernel_length)];
reference_chirp=azimuth_LUT(LUT_index,2:kernel_length);

h=[reference_chirp zeros(1,azimuth_steps-kernel_length+1)];

H=fft(h);
freq_kernels(k,:)=1;
AZCH=fft(azimuth_chirp);

COMPRESSED=AZCH.*H;

compressed=ifft(COMPRESSED);

SAR_azimuth_compressed(:,k)=compressed;


    if(k==61)
        figure
        plot(real(azimuth_chirp));
        title("chirp and h")
        hold on
        plot(real(h));
        legend("AZ chirp","h")
        hold off
    end



%     if(k==61)
% 
% 
%         figure
%         tiledlayout(1,2)
%         nexttile
%         plot(real(H)/1024);
%         title("FREQ")
%         hold on
%         plot(real(AZCH)/1024);
%         plot(real(filtered)/1024);
%         % plot(real(AZCH));
%         legend("H","AZCH")
%         hold off
%         nexttile
%         % plot(real(ifft(OUT2)));
%         plot(real(out2),"-x");
%         hold on
%         plot(real(filtered));
%         legend("Frequency domain filter","time domain filter")
%         title("Comparison of time and frequency domain filters")
%         xlabel("Sample no.")
%         ylabel("MAgnitude (linear scale)")
%     end


%         if(k==61)
%         figure
%         plot(real(filtered)/max(real(filtered)));
%         title("FREQ")
%         hold on
%         plot(real(azimuth_chirp));
%         plot(real(azimuth_LUT(k,:)));
%         % plot(real(AZCH));
%         hold off
%     end


end








% SAR_azimuth_compressed=zeros(azimuth_steps,samples);



% for k=1:samples

%     azimuth_chirp=SAR_range_corrected(:,k)';
%     AZCH=fft(azimuth_chirp);
%     h=azimuth_LUT(k,:);
%     filtered=conv(h,azimuth_chirp);
%     filtered=filtered(floor(length(h)/2):end-(floor(length(h)/2)));
%      % h=h(end:-1:1);
%      % h=conj(h);

%     h=[h zeros(1,azimuth_steps-length(h))];
%     % w=blackman(length(h));
%     % h=h.*w;


%     H=fft(h);
%     freq_kernels(k,:)=H;
%     %filtered=filter(h,1,azimuth_chirp);

%     OUT=azimuth_chirp.*H;
%     OUT2=AZCH.*H;
%     % OUT2=fftshift(OUT2);
%     % filtered=OUT;


%     if(k==61)
%         figure
%         plot(real(azimuth_chirp));
%         title("chirp and h")
%         hold on
%         plot(real(h));
%         legend("AZ chirp","h")
%         hold off
%     end


%     out2=ifft(OUT2);
%     % out2=circshift(out2,500,2);
%     % out2=out2(end:-1:1);
%     % out2=out2(500+13:end);
%     % out2=out2(floor(250/2):end-(floor(250/2)));

%     if(k==61)


%         figure
%         tiledlayout(1,2)
%         nexttile
%         plot(real(H)/1024);
%         title("FREQ")
%         hold on
%         plot(real(AZCH)/1024);
%         plot(real(filtered)/1024);
%         % plot(real(AZCH));
%         legend("H","AZCH")
%         hold off
%         nexttile
%         % plot(real(ifft(OUT2)));
%         plot(real(out2),"-x");
%         hold on
%         plot(real(filtered));
%         legend("Frequency domain filter","time domain filter")
%         title("Comparison of time and frequency domain filters")
%         xlabel("Sample no.")
%         ylabel("MAgnitude (linear scale)")
%     end


%     % filtered=filtered(floor(length(h)/2):end-(floor(length(h)/2)));
%     filtered=ifft(filtered);
%     % SAR_azimuth_compressed(:,k)=filtered;
%     SAR_azimuth_compressed(:,k)=out2;

%     if(k==61)
%         figure
%         plot(real(filtered)/max(real(filtered)));
%         title("FREQ")
%         hold on
%         plot(real(azimuth_chirp));
%         plot(real(azimuth_LUT(k,:)));
%         % plot(real(AZCH));
%         hold off
%     end


% end
% end



% %filter kernel in freq domain (H)
% %FFT of azimuth signal (FFT of rows)
% %element by element multiplication
% %IFFT of output -> this is azimuth compressed
