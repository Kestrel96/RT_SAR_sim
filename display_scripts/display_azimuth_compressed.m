figure
colormap jet
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_azimuth_compressed)))
%imagesc(raxis,azimuth_axis,abs(real(radar.SAR_range_compressed)))

xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Azimuth Compressed")



%draw_targets
 ax = gca;
 ax.YDir= 'normal';

 
%draw_targets