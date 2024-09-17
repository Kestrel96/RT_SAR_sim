range_corrected_figure=figure('Name','Range Correction','Numbertitle','off','Position', [0 0 1600 900]);
colormap gray


tiledlayout(2,2)
nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_doppler)));
cb=colorbar();
cb.FontWeight='bold';
cb.FontSize=15;
ylabel(cb,"Power (db)")
t=title("a) Range Doppler data");
t.FontSize=18;
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=15;
lbl_x.FontWeight='bold';
lbl_y=ylabel("Azimuth Frequency [Hz]");
lbl_y.FontSize=15;
lbl_y.FontWeight='bold';
ax = gca;
ax.FontWeight='bold';

nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_RD_range_corrected)));
cb=colorbar();
cb.FontWeight='bold';
cb.FontSize=15;
ylabel(cb,"Power (db)")
t=title("b) Range Doppler Data After RCMC");
t.FontSize=18;
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=15;
lbl_x.FontWeight='bold';
lbl_y=ylabel("Azimuth Frequency [Hz]");
lbl_y.FontSize=15;
lbl_y.FontWeight='bold';
ax = gca;
ax.FontWeight='bold';

nexttile
imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_compressed)));
cb=colorbar();
cb.FontWeight='bold';
cb.FontSize=15;
ylabel(cb,"Power (db)")
clim([db_thrsh 0])
t=title("c) Range Compressed Data (Pre RCMC)");
t.FontSize=18;
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=15;
lbl_x.FontWeight='bold';
lbl_y=ylabel("Cross-Range [m]");
lbl_y.FontSize=15;
lbl_y.FontWeight='bold';
ax = gca;
ax.FontWeight='bold';
ax.YDir= 'normal';

nexttile
range_corrected_time=range_doppler_invert(radar.SAR_RD_range_corrected,range_doppler_invert_shift);
imagesc(raxis,rd_axis,dbn(abs(range_corrected_time)));
cb=colorbar();
cb.FontWeight='bold';
cb.FontSize=15;
ylabel(cb,"Power (db)")
clim([db_thrsh 0])
t=title("d) Range Compressed Data (Post RCMC)");
t.FontSize=18;
lbl_x=xlabel("Range [m]");
lbl_x.FontSize=15;
lbl_x.FontWeight='bold';
lbl_y=ylabel("Cross-Range [m]");
lbl_y.FontSize=15;
lbl_y.FontWeight='bold';
ax = gca;
ax.FontWeight='bold';
ax.YDir= 'normal';

saveas(range_corrected_figure,"./graphics/range_correction_"+suffix+".png");
%saveas(range_corrected_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_"+suffix+".png");

%% Display RCMC effect
if suffix=="sim"
    rcmc_effect_figure=figure('Name','Range Correction Effect','NumberTitle','off','Position', [0 0 1600 900]);
    colormap gray

    tiledlayout(1,2)

    nexttile
    imagesc(raxis,azimuth_axis,dbn(abs(radar.SAR_range_compressed)));
    clim([db_thrsh 0])
    cb=colorbar();
    cb.FontWeight='bold';
    cb.FontSize=15;
    ylabel(cb,"Power (db)")


    t=title("a) Range Compressed Data Prior to RCMC");
    t.FontSize=20;
    lbl_x=xlabel("Range [m]");
    lbl_x.FontSize=18;
    lbl_x.FontWeight='bold';
    lbl_y=ylabel("Cross-Range [m]");
    lbl_y.FontSize=18;
    lbl_y.FontWeight='bold';
    ax = gca;
    ax.FontWeight='bold';
    ax.YDir= 'normal';
    xlim([targets(1).x-10,targets(1).x+10]);


    draw_targets

    nexttile
    imagesc(raxis,azimuth_axis,dbn(abs(range_corrected_time)));
    clim([db_thrsh 0])
    cb=colorbar();
    cb.FontWeight='bold';
    cb.FontSize=15;
    cb_lbl = ylabel(cb,"Power (db)");

    t=title("b) Effect of RCMC");
    t.FontSize=20;
    lbl_x=xlabel("Range [m]");
    lbl_x.FontSize=18;
    lbl_x.FontWeight='bold';
    lbl_y=ylabel("Cross-Range [m]");
    lbl_y.FontSize=18;
    lbl_y.FontWeight='bold';
    ax = gca;
    ax.FontWeight='bold';
    ax.YDir= 'normal';
    xlim([targets(1).x-10,targets(1).x+10]);
    draw_targets


    saveas(rcmc_effect_figure,"./graphics/range_correction_effect_"+suffix+".png");
    %    saveas(rcmc_effect_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_effect_"+suffix+".png");
end









































%Version with 4 plots on one figure below:

% range_corrected_figure=figure('Name','Range Correction','Numbertitle','off','Position', [0 0 1600 900]);
% colormap gray
% 
% 
% tiledlayout(2,2)
% nexttile
% imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_doppler)));
% cb=colorbar();
% cb.FontWeight='bold';
% cb.FontSize=15;
% ylabel(cb,"Power (db)")
% t=title("a) Range Doppler data");
% t.FontSize=18;
% lbl_x=xlabel("Range [m]");
% lbl_x.FontSize=15;
% lbl_x.FontWeight='bold';
% lbl_y=ylabel("Azimuth Frequency [Hz]");
% lbl_y.FontSize=15;
% lbl_y.FontWeight='bold';
% ax = gca;
% ax.FontWeight='bold';
% 
% nexttile
% imagesc(raxis,rd_axis,dbn(abs(radar.SAR_RD_range_corrected)));
% cb=colorbar();
% cb.FontWeight='bold';
% cb.FontSize=15;
% ylabel(cb,"Power (db)")
% t=title("b) Range Doppler Data After RCMC");
% t.FontSize=18;
% lbl_x=xlabel("Range [m]");
% lbl_x.FontSize=15;
% lbl_x.FontWeight='bold';
% lbl_y=ylabel("Azimuth Frequency [Hz]");
% lbl_y.FontSize=15;
% lbl_y.FontWeight='bold';
% ax = gca;
% ax.FontWeight='bold';
% 
% nexttile
% imagesc(raxis,rd_axis,dbn(abs(radar.SAR_range_compressed)));
% cb=colorbar();
% cb.FontWeight='bold';
% cb.FontSize=15;
% ylabel(cb,"Power (db)")
% clim([db_thrsh 0])
% t=title("c) Range Compressed Data (Pre RCMC)");
% t.FontSize=18;
% lbl_x=xlabel("Range [m]");
% lbl_x.FontSize=15;
% lbl_x.FontWeight='bold';
% lbl_y=ylabel("Azimuth Distance [m]");
% lbl_y.FontSize=15;
% lbl_y.FontWeight='bold';
% ax = gca;
% ax.FontWeight='bold';
% ax.YDir= 'normal';
% 
% nexttile
% range_corrected_time=range_doppler_invert(radar.SAR_RD_range_corrected,range_doppler_invert_shift);
% imagesc(raxis,rd_axis,dbn(abs(range_corrected_time)));
% cb=colorbar();
% cb.FontWeight='bold';
% cb.FontSize=15;
% ylabel(cb,"Power (db)")
% clim([db_thrsh 0])
% t=title("d) Range Compressed Data (Post RCMC)");
% t.FontSize=18;
% lbl_x=xlabel("Range [m]");
% lbl_x.FontSize=15;
% lbl_x.FontWeight='bold';
% lbl_y=ylabel("Azimuth Distance [m]");
% lbl_y.FontSize=15;
% lbl_y.FontWeight='bold';
% ax = gca;
% ax.FontWeight='bold';
% ax.YDir= 'normal';
% 
% saveas(range_corrected_figure,"./graphics/range_correction_"+suffix+".png");
% %saveas(range_corrected_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_"+suffix+".png");
% 
% %% Display RCMC effect
% if suffix=="sim"
%     rcmc_effect_figure=figure('Name','Range Correction Effect','NumberTitle','off','Position', [0 0 1600 900]);
%     colormap gray
% 
%     tiledlayout(1,2)
% 
%     nexttile
%     imagesc(raxis,azimuth_axis,dbn(abs(radar.SAR_range_compressed)));
%     clim([db_thrsh 0])
%     cb=colorbar();
%     cb.FontWeight='bold';
%     cb.FontSize=15;
%     ylabel(cb,"Power (db)")
% 
% 
%     t=title("a) Range Compressed Data Prior to RCMC");
%     t.FontSize=20;
%     lbl_x=xlabel("Range [m]");
%     lbl_x.FontSize=18;
%     lbl_x.FontWeight='bold';
%     lbl_y=ylabel("Azimuth Distance [m]");
%     lbl_y.FontSize=18;
%     lbl_y.FontWeight='bold';
%     ax = gca;
%     ax.FontWeight='bold';
%     ax.YDir= 'normal';
%     xlim([targets(1).x-10,targets(1).x+10]);
% 
% 
%     draw_targets
% 
%     nexttile
%     imagesc(raxis,azimuth_axis,dbn(abs(range_corrected_time)));
%     clim([db_thrsh 0])
%     cb=colorbar();
%     cb.FontWeight='bold';
%     cb.FontSize=15;
%     cb_lbl = ylabel(cb,"Power (db)");
% 
%     t=title("b) Effect of RCMC");
%     t.FontSize=20;
%     lbl_x=xlabel("Range [m]");
%     lbl_x.FontSize=18;
%     lbl_x.FontWeight='bold';
%     lbl_y=ylabel("Azimuth Distance [m]");
%     lbl_y.FontSize=18;
%     lbl_y.FontWeight='bold';
%     ax = gca;
%     ax.FontWeight='bold';
%     ax.YDir= 'normal';
%     xlim([targets(1).x-10,targets(1).x+10]);
%     draw_targets
% 
% 
%     saveas(rcmc_effect_figure,"./graphics/range_correction_effect_"+suffix+".png");
%     %    saveas(rcmc_effect_figure,"/home/kuba/Desktop/RT_SAR/RT_SAR_thesis/graphics/range_correction_effect_"+suffix+".png");
% end