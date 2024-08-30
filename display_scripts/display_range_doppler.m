range_doppler_figure=figure('Name','RangeDoppler','NumberTitle','off','Position', [0 0 1600 900]);
colormap gray

doppler_axis=(-azimuth_samples/2:((azimuth_samples/2)-1))*PRF/azimuth_samples;
imagesc(raxis,doppler_axis,dbn(abs(radar.SAR_range_doppler)))
clim([db_thrsh 0])
cb=colorbar();
ylabel(cb,"Power (db)")
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=20;
lbl_x.FontWeight='bold';

lbl_y=ylabel("Azimuth Frequency [Hz]");
lbl_y.FontSize=20;
lbl_y.FontWeight='bold';

t=title("Range Doppler");
t.FontWeight = 'bold';
t.FontSize = 20;

ax = gca;
ax.FontWeight='bold';
%ax.YDir= 'normal';
saveas(range_doppler_figure,"./graphics/range_doppler_"+suffix+".png");
