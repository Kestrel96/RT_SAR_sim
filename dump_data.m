%% Save raw data

f= fopen('./data/sar_raw.bin','wb');
fwrite(f,[length(radar.SAR_raw_data),width(radar.SAR_raw_data)],'uint');

for i=1:length(radar.SAR_raw_data)
    fwrite(f,real(radar.SAR_raw_data(i,:)),'single');

end

for i=1:length(radar.SAR_raw_data)
    fwrite(f,imag(radar.SAR_raw_data(i,:)),'single');

end

fclose(f);


%% Save range compressed data

f= fopen('./data/sar_range_compressed.bin','wb');
fwrite(f,[length(radar.SAR_range_compressed),width(radar.SAR_range_compressed)],'uint');

for i=1:length(radar.SAR_range_compressed)
    fwrite(f,real(radar.SAR_range_compressed(i,:)),'single');

end

for i=1:length(radar.SAR_range_compressed)
    fwrite(f,imag(radar.SAR_range_compressed(i,:)),'single');

end

fclose(f);

%% test

% a=[1.1,2.1,3.1;4,5,6];
% f= fopen('test.bin','wb');
% fwrite(f,[2,3],'uint');
% 
% for i=1:length(a)
%     fwrite(f,real(a),'single');
% 
% end
% fclose(f);
