
final_results_figure=figure('Name','FInal Output','NumberTitle','off','Position', [0 0 1600 900]);
tiledlayout(1,4)
nexttile
imagesc(real(radar.SAR_raw_data))
xlabel("Samples")
ylabel("Pulse (Azimuth)")
title("SAR Raw Data")
ax = gca;
ax.YDir= 'normal';

nexttile
imagesc(raxis,azimuth_axis,db(abs(SAR_range_compressed)))
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data")
xlim([0,max_range])
ax = gca;
ax.YDir= 'normal';
nexttile
imagesc(raxis,azimuth_axis,db(abs(SAR_range_corrected)))
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data (Post RCMC)")
xlim([0,max_range])
ax = gca;
ax.YDir= 'normal';
nexttile
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_azimuth_compressed)))
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Azimuth Compressed Data")
%xlim([0,max_range])
ax = gca;
ax.YDir= 'normal';

saveas(final_results_figure,"./graphics/final_results.png");