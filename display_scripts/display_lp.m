figure
imagesc(rangeAxis,azimuth_axis,(abs(SAR_LP)));
xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Range Compressed Data")
% xlim([0,max_range])
%ax = gca;
%ax.YDir= 'normal';
%draw_targets