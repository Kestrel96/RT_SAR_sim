function SAR_azimuth_compressed = azimuth_compression(SAR_range_corrected,azimuth_LUT)
%AZIMUTH_COMPRESSION Summary of this function goes here
%   Detailed explanation goes here










[azimuth_steps,samples]=size(SAR_range_corrected);

SAR_azimuth_compressed=zeros(azimuth_steps,samples);
for k=1:samples

    azimuth_chirp=SAR_range_corrected(:,k);
    h=azimuth_LUT(k,:)';
    w=blackman(length(h));
    h=h.*w;
    %filtered=filter(h,1,azimuth_chirp);
    filtered=conv(h,azimuth_chirp);
    filtered=filtered(floor(length(h)/2):end-(floor(length(h)/2)));
    

     if(k==61)
         figure
         plot(real(filtered)/max(real(filtered)));
         title("TIME")
         hold on
         plot(real(azimuth_chirp));
         plot(real(azimuth_LUT(k,:)));
         hold off
     end

    SAR_azimuth_compressed(:,k)=filtered;

end
end

