range_corrected_figure=figure('Name','Range Correction','NumberTitle','off','Position', [0 0 1600 900]);
colormap gray


tiledlayout(2,2)
nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_doppler)));
cb=colorbar();
ylabel(cb,"Power (db)")
title("Range Doppler data")
xlabel("Range [m]")
ylabel("Doppler frequency [Hz]")

nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_RD_range_corrected)));
cb=colorbar();
ylabel(cb,"Power (db)")
title("Range Doppler Data After RCMC")
xlabel("Range [m]")
ylabel("Doppler frequency [Hz]")

nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_compressed)));
cb=colorbar();
ylabel(cb,"Power (db)")
clim([-50 0])
title("Range Compressed Data (Pre RCMC)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
ax = gca;
ax.YDir= 'normal';

nexttile
range_corrected_time=range_doppler_invert(radar.SAR_RD_range_corrected,range_doppler_invert_shift);
imagesc(raxis,rd_axis,dbn(abs(range_corrected_time)));
cb=colorbar();
ylabel(cb,"Power (db)")
clim([-50 0])
title("Range Compressed Data (Post RCMC)")
xlabel("Range [m]")
ylabel("Azimuth distance [m]")
ax = gca;
ax.YDir= 'normal';

saveas(range_corrected_figure,"./graphics/range_correction_"+suffix+".png");
saveas(range_corrected_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_"+suffix+".png");

%% Display RCMC effect
if suffix=="sim"
    rcmc_effect_figure=figure('Name','Range Correction Effect','NumberTitle','off','Position', [0 0 1600 900]);
    colormap gray

    tiledlayout(1,2)

    nexttile
    imagesc(raxis,azimuth_axis,dbn(abs(radar.SAR_range_compressed)));
    clim([-50 0])
    cb=colorbar();
    ylabel(cb,"Power (db)")


    title("Range Compressed Data Prior to RCMC")
    xlabel("Range [m]")
    ylabel("Azimuth distance [m]")
    ax = gca;
    ax.YDir= 'normal';
    xlim([targets(1).x-10,targets(1).x+10]);

    draw_targets

    nexttile
    imagesc(raxis,azimuth_axis,dbn(abs(range_corrected_time)));
    clim([-50 0])
    cb=colorbar();
    ylabel(cb,"Power (db)")
    title("Effect of RCMC")
    xlabel("Range [m]")
    ylabel("Azimuth distance [m]")
    ax = gca;
    ax.YDir= 'normal';
    xlim([targets(1).x-10,targets(1).x+10]);
    draw_targets


    saveas(rcmc_effect_figure,"./graphics/range_correction_effect_"+suffix+".png");
    saveas(rcmc_effect_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_effect_"+suffix+".png");
end