
sar_raw_data_figure=figure('Name','SARRawData','NumberTitle','off','Position', [0 0 1600 900]);
imagesc(real(radar.SAR_raw_data))
xlabel("Samples")
ylabel("Pulse (Azimuth)")
title("SAR Raw Data")
ax = gca;
ax.YDir= 'normal';


saveas(sar_raw_data_figure,"./graphics/sar_raw_data_"+suffix+".png");
