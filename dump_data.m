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

%% Save range corrected data
f= fopen('./data/sar_range_corrected.bin','wb');
fwrite(f,[length(radar.SAR_range_corrected),width(radar.SAR_range_corrected)],'uint');

for i=1:length(radar.SAR_range_corrected)
    fwrite(f,real(radar.SAR_range_corrected(i,:)),'single');

end

for i=1:length(radar.SAR_range_corrected)
    fwrite(f,imag(radar.SAR_range_corrected(i,:)),'single');

end

fclose(f);

%% Save azimuth compression LUT
f= fopen('./data/sar_azimuth_reference_LUT.bin','wb');
fwrite(f,[length(radar.SAR_azimuth_reference_LUT),width(radar.SAR_azimuth_reference_LUT)],'uint');

for i=1:length(radar.SAR_azimuth_reference_LUT)
    fwrite(f,real(radar.SAR_azimuth_reference_LUT(i,:)),'single');

end

for i=1:length(radar.SAR_azimuth_reference_LUT)
    fwrite(f,imag(radar.SAR_azimuth_reference_LUT(i,:)),'single');

end

fclose(f);


%% Save RCMC shifts
f= fopen('./data/delta_samples.bin','wb');
fwrite(f,[length(delta_samples),width(delta_samples)],'uint');

for i=1:length(delta_samples)
    fwrite(f,real(delta_samples(i,:)),'single');

end

for i=1:length(delta_samples)
    fwrite(f,imag(delta_samples(i,:)),'single');

end

fclose(f);



%% Save LUT
f= fopen('./data/LUT.bin','wb');
fwrite(f,[length(radar.SAR_azimuth_compressed),width(radar.SAR_azimuth_compressed)],'uint');

for i=1:length(radar.SAR_azimuth_compressed)
    fwrite(f,real(radar.SAR_azimuth_compressed(i,:)),'single');

end

for i=1:length(radar.SAR_azimuth_compressed)
    fwrite(f,imag(radar.SAR_azimuth_compressed(i,:)),'single');

end

fclose(f);


%% Save fKernels
f= fopen('./data/fKernels.bin','wb');
fwrite(f,[length(fkernels),width(fkernels)],'uint');

for i=1:length(delta_samples)
    fwrite(f,real(delta_samples(i,:)),'single');

end

for i=1:length(delta_samples)
    fwrite(f,imag(delta_samples(i,:)),'single');

end

fclose(f);