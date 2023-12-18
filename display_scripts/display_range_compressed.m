range_compressed_figure=figure('Name','RangeCompressed','NumberTitle','off','Position', [0 0 1600 900]);
imagesc(raxis,azimuth_axis,dbn(abs(radar.SAR_range_compressed)))
cb=colorbar();
ylabel(cb,"Power (db)")
colormap gray
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data")
clim([-50,0]);
% xlim([0,max_range])
% ax = gca;
% ax.YDir= 'normal';
if suffix == "sim"
draw_targets
end
saveas(range_compressed_figure,"./graphics/range_compressed_"+suffix+".png");
saveas(range_compressed_figure,"../RT_SAR_thesis/graphics/range_compressed_"+suffix+".png");
