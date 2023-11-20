function SAR_range_compressed = range_compression(SAR_raw_data)
%RANGE_COMPRESSION Summary of this function goes here
%   Detailed explanation goes here
    
    [rows,cols]=size(SAR_raw_data);
    SAR_range_compressed=zeros(rows,cols);
    for i=1:rows
        %SAR_range_compressed(i,:)=ifftshift(ifft(SAR_raw_data(i,:)));
        SAR_range_compressed(i,:)=fftshift(fft(SAR_raw_data(i,:)));

    end
end

