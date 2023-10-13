function range_doppler_data = range_doppler_transform(range_compressed_data)
%RANGE_DOPPLER_TRANSFORM Summary of this function goes here
%   Detailed explanation goes here

[rows,columns]=size(range_compressed_data);
range_doppler_data=fft(range_compressed_data,[],1);
%H=freqz(doppler_filter_num,1,rows);
% for k=1:columns
%     range_doppler_data(:,k)=fftfilt(doppler_filter_num,range_doppler_data(:,k),rows);
%     %range_doppler_data(:,k)=fftfilt(doppler_filter_num,1,range_doppler_data(:,k));
% end
range_doppler_data=fftshift(range_doppler_data,1);

end

