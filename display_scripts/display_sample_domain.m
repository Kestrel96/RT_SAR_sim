tiledlayout(1,4)
nexttile
imagesc(real(radar.SAR_raw_data))
xlabel("Samples")
ylabel("Pulse (Azimuth)")
title("SAR Raw Data")
ax = gca;
ax.YDir= 'normal';

nexttile
imagesc(db(abs(SAR_range_compressed)))
xlabel("Samples (range)")
ylabel("Samples (azimuth)")
title("Range Compressed Data")
ax = gca;
ax.YDir= 'normal';
nexttile
% imagesc(abs(SAR_range_corrected))
% xlabel("Samples (range)")
% ylabel("Samples (azimuth)")
% title("Range Compressed Data (Post RCMC)")
% ax = gca;
% ax.YDir= 'normal';
% nexttile
% imagesc(abs(radar.SAR_azimuth_compressed))
% xlabel("Samples (range)")
% ylabel("Samples (azimuth)")
% title("Azimuth Compressed Data")
% ax = gca;
% ax.YDir= 'normal';

