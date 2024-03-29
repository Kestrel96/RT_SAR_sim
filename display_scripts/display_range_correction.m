% range_corrected_figure=figure('Name','Range Correction','NumberTitle','off','Position', [0 0 1600 900]);
% tiledlayout(2,2)
% nexttile
% imagesc(raxis,rd_axis,abs(RD_data));
% % xlim([0,max_range])
% title("Range Doppler data")
% xlabel("Range [m]")
% ylabel("Azimuth frequency [1/m]?")
% nexttile
% imagesc(raxis,rd_axis,abs(RD_range_corrected));
% % xlim([0,max_range])
% title("Range Doppler Data After RCMC")
% xlabel("Range [m]")
% ylabel("Azimuth frequency [1/m]?")
% nexttile
% imagesc(raxis,azimuth_axis,abs(SAR_range_compressed));
% % xlim([0,max_range])
% title("Range Compressed Data (Pre RCMC)")
% xlabel("Range [m]")
% ylabel("Azimuth distance [m]")
% nexttile
% imagesc(abs(SAR_range_corrected));
% % xlim([0,max_range])
% title("Range Compressed Data (Post RCMC)")
% xlabel("Range [m]")
% ylabel("Azimuth distance [m]")

% saveas(range_corrected_figure,"./graphics/range_correction.png");

% figure 
% plot(real(SAR_range_corrected(:,48)));
% figure 
% plot(real(SAR_range_corrected(:,68)));


range_corrected_figure=figure('Name','Range Correction','NumberTitle','off','Position', [0 0 1600 900]);
tiledlayout(2,2)
nexttile
imagesc(raxis,rd_axis,db(abs(radar.SAR_range_doppler)));
xlim([0,max_range])
title("Range Doppler data")
xlabel("Range [m]")
ylabel("Doppler frequency [Hz]")
nexttile
imagesc(raxis,rd_axis,db(abs(RD_range_corrected)));
 xlim([0,max_range])
title("Range Doppler Data After RCMC")
xlabel("Range [m]")
ylabel("Doppler frequency [Hz]")

nexttile
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_range_compressed)));
 xlim([0,max_range])
title("Range Compressed Data (Pre RCMC)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
draw_targets
ax = gca;
ax.YDir= 'normal';

nexttile
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_range_corrected)));
xlim([0,max_range])
%imagesc(db(abs(radar.SAR_range_corrected)));
title("Range Compressed Data (Post RCMC)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
draw_targets
ax = gca;
ax.YDir= 'normal';
