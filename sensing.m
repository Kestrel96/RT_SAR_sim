radar.SAR_raw_data=zeros(azimuth_samples,samples);% init Raw Data array
radar=radar.get_ant_vertices(max_range);
noise_mult=1;

for k=1:azimuth_samples

    tmp_signal=zeros(1,samples);
    for l=1:length(targets)

        illuminated=targets(l).is_illuminated(radar.y);

        if(illuminated) % Targets reflect only if illuminated
            %targets(l)=targets(l).get_inst_range2(radar.x,radar.y);\


            tmp_signal=tmp_signal+targets(l).get_beat(radar.y,Alfa,t,fc);
           tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise

        else
            tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise

        end


    end

    radar.SAR_raw_data(k,:)=tmp_signal;

    radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
    radar=radar.get_ant_vertices(max_range);
    %disp(k)

end

%%
% figure
% tiledlayout(1,2)
% nexttile


% imagesc(sample_axis,azimuth_axis,abs(radar.SAR_raw_data));
% xlabel("Sample")
% ylabel("Azimuth distance [m]")
% ax = gca;
% ax.YDir= 'normal';
% nexttile
% show_scene

