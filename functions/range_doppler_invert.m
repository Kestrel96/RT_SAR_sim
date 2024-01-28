function RD_ifft = range_doppler_invert(range_doppler_data,rd_invert_shift)
%RANGE_DOPPLER_INVERT Summary of this function goes here
%   Detailed explanation goes here


RD_ifft=ifft(range_doppler_data,[],1);
if rd_invert_shift
    RD_ifft=fftshift(RD_ifft,1);
end

%RD_ifft=range_doppler_data;


end

