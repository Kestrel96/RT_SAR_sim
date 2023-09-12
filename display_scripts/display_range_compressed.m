figure
imagesc(raxis,azimuth_axis,abs(radar.SAR_range_compressed))
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data")
xlim([0,max_range])
ax = gca;
ax.YDir= 'normal';
%draw_targets