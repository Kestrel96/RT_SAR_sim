range_doppler_figure=figure('Name','RangeDoppler','NumberTitle','off','Position', [0 0 1600 900]);
colormap gray

doppler_axis=(-azimuth_samples/2:((azimuth_samples/2)-1))*PRF/azimuth_samples;
imagesc(raxis,doppler_axis,dbn(abs(radar.SAR_range_doppler)))
clim([-50 0])
cb=colorbar();
ylabel(cb,"Power (db)")
xlabel("Range [m]")
ylabel("Doppler freq [m]")
title("Range Doppler")
ax = gca;
%ax.YDir= 'normal';
saveas(range_doppler_figure,"./graphics/range_doppler_"+suffix+".png");
saveas(range_doppler_figure,"../RT_SAR_thesis/graphics/range_doppler_"+suffix+".png");
