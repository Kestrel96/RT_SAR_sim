function SAR_range_compressed = range_compresion(SAR_raw_data,no_pulses)
%RANGE_COMPRESION Performs FFT on every row of SAR_raw_data array. Output
%is range compressed array.
%   Detailed explanation goes here


SAR_range_compressed=zeros(size(SAR_raw_data));

for k=1:no_pulses
    SAR_range_compressed(k,:)=fft(SAR_raw_data(k,:));
end


end

