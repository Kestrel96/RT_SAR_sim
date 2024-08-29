

sar_raw_data_figure=figure('Name','SARRawData','NumberTitle','off','Position', [0 0 1600 900]);
imagesc(real(radar.SAR_raw_data))
colormap gray
lbl_x=xlabel("Sample");
lbl_x.FontSize=20;
lbl_x.FontWeight='bold';

lbl_y=ylabel("Pulse (Azimuth)");
lbl_y.FontSize=20;
lbl_y.FontWeight='bold';
t=title("SAR Raw Data");
t.FontSize=20;
t.FontWeight='Bold';
ax = gca;
ax.FontWeight='bold';
ax.YDir= 'normal';


saveas(sar_raw_data_figure,"./graphics/sar_raw_data_"+suffix+".png");
