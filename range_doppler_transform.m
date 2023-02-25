function range_doppler_data = range_doppler_transform(range_compressed_data)
%RANGE_DOPPLER_TRANSFORM Summary of this function goes here
%   Detailed explanation goes here
range_doppler_data=fft(range_compressed_data,[],1);
range_doppler_data=fftshift(range_doppler_data,1);

end

