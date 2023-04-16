figure
tiledlayout(1,2)
nexttile
for k=1:length(targets)
    scatter(targets(k).x,targets(k).y,'LineWidth',5);
    hold on
end

scatter(radar.x,radar.y,"x",'LineWidth',5)
plot([radar.x,radar.ant_x], [radar.y,radar.ant_y_upper],'-.' ...
    ,[radar.x,radar.ant_x], [radar.y,radar.ant_y_lower],'-.')
xlim([0,max_range]);
ylim([-1,azimuth_distance+10]);
title("Scene setup")
xlabel("Range [m]")
ylabel("Azimuth [m]")
% h1 = axes;
% set(h1, 'Ydir', 'reverse')
% set(h1, 'YAxisLocation', 'Right')
hold off
nexttile 
imagesc(real(radar.SAR_azimuth_compressed))
ax = gca;
ax.YDir= 'normal';
title("Azimuth Compressed")
colorbar
colormap("gray")