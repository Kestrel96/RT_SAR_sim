radar.SAR_raw_data=zeros(azimuth_samples,range_samples);% init Raw Data array
radar=radar.get_ant_vertices(max_range);
noise_mult=1;

fprintf("Sensing\n");
for k=1:azimuth_samples

    tmp_signal=zeros(1,samples);
    for l=1:length(targets)

        illuminated=targets(l).is_illuminated(radar.y);

        if(illuminated) % Targets reflect only if illuminated


            tmp_signal=tmp_signal+targets(l).get_beat(radar.y,Alfa,t,fc);
            tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise

        else
            tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise

        end


    end

    radar.SAR_raw_data(k,:)=tmp_signal;

    radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
    radar=radar.get_ant_vertices(max_range);
    if mod(k,128)==0
        fprintf(".")

    end

    if mod(k,2048)==0
        fprintf("step: %u/%u\n",k,azimuth_samples)
    end

end



% fprintf("Sensing\n");
% for k=1:azimuth_samples
% 
%     tmp_signal=zeros(1,samples);
%     for l=1:length(targets)
% 
%         illuminated=targets(l).is_illuminated(radar.y);
% 
%         if(illuminated) % Targets reflect only if illuminated
% 
% 
%             tmp_signal=tmp_signal+targets(l).get_beat(radar.y,Alfa,t,fc);
%             tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise
% 
%         else
%             tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*noise_mult;% add noise
% 
%         end
% 
% 
%     end
% 
%     radar.SAR_raw_data(k,:)=tmp_signal;
% 
%     radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
%     radar=radar.get_ant_vertices(max_range);
%     if mod(k,128)==0
%         fprintf(".")
% 
%     end
% 
%     if mod(k,2048)==0
%         fprintf("step: %u/%u\n",k,azimuth_samples)
%     end
% 
% end




