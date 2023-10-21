figure
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_azimuth_compressed)))
%imagesc(raxis,azimuth_axis,real(radar.SAR_range_compressed))

xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data")

 ax = gca;
 ax.YDir= 'normal';
%draw_targets