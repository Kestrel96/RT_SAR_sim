close all
azimuth_chirp=radar.SAR_range_corrected(:,226);
azimuth_ref=radar.SAR_azimuth_reference_LUT(226,2:end);
plot(real(azimuth_chirp));
hold on
plot(real(azimuth_ref));