final_result_figure=figure('Name','FinalResult','NumberTitle','off','Position', [0 0 1600 900]);
colormap gray
cb=colorbar();
ylabel(cb,"Power (db)")

imagesc(raxis,azimuth_axis,dbn(radar.SAR_azimuth_compressed));
clim([-80,0]);

%imagesc(raxis,azimuth_axis,db(abs(radar.SAR_azimuth_compressed)))
cb=colorbar();
ylabel(cb,"Power (db)")

%imagesc(raxis,azimuth_axis,abs(real(radar.SAR_range_compressed)))

xlabel("Range [m]")
ylabel("Azimuth [m]")
title("Azimuth Compressed")
%draw_targets
ax = gca;
ax.YDir= 'normal';
%ax.XDir='reverse';

if suffix == "sim"
draw_targets
end

saveas(final_result_figure,"./graphics/azimuth_compressed_"+suffix+".png");
saveas(final_result_figure,"../RT_SAR_thesis/graphics/azimuth_compressed_"+suffix+".png");
%% Show single compressed target
if suffix=="sim"
    single_target_final_figure=figure('Name','Azimuth Compression Single Target','NumberTitle','off','Position', [0 0 1600 900]);
    colormap gray




    imagesc(raxis,azimuth_axis,dbn(radar.SAR_azimuth_compressed));
clim([-50,0]);
cb=colorbar();
ylabel(cb,"Power (db)")
    title("Single Target After Azimuth Compression")
    xlabel("Range [m]")
    ylabel("Azimuth distance [m]")
    ax = gca;
    ax.YDir= 'normal';
    xlim([targets(1).x-1,targets(1).x+1]);
    ylim([targets(1).y-2,targets(1).y+2]);
    text(targets(1).x+0.1,targets(1).y,"Target 1",BackgroundColor="red")

    
    draw_targets



    saveas(single_target_final_figure,"./graphics/azimuth_compression_single_target_"+suffix+".png");
    saveas(single_target_final_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/azimuth_compression_single_target_"+suffix+".png");
end


