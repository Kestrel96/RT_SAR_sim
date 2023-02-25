function RD_ifft = range_doppler_invert(range_doppler_data)
%RANGE_DOPPLER_INVERT Summary of this function goes here
%   Detailed explanation goes here

RD_ifft=fftshift(range_doppler_data,1);
RD_ifft=ifft(RD_ifft,[],1);

end

