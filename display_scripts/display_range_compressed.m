
if exist('db_thrsh') ~= 1
    db_thrsh = -60;
end



range_compressed_figure=figure('Name','RangeCompressed','NumberTitle','off','Position', [0 0 1600 900]);
imagesc(raxis,azimuth_axis,dbn(abs(radar.SAR_range_compressed)))
cb=colorbar();
ylabel(cb,"Power (db)")
colormap gray
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=20;
lbl_x.FontWeight='bold';

lbl_y=ylabel("Azimuth [m]");
lbl_y.FontSize=20;
lbl_y.FontWeight='bold';

t=title("Range Compressed Data");
t.FontSize=20;
t.FontWeight='bold';
clim([db_thrsh,0]);
% xlim([0,max_range])
ax = gca;
ax.FontWeight='bold';
% ax.YDir= 'normal';
if suffix == "sim"
draw_targets
end
saveas(range_compressed_figure,"./graphics/range_compressed_"+suffix+".png");
