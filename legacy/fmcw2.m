close all
clear


%% Platform Parameters
c=3e8;
fc=5e9; % carrier
B=25e6; % Bandwidth
T=10e-3; % Chirp time
Beta=B/T; % slope
ant_angle=60; %antenna aperture angle
v=75; % platform's velocity
PRI=4e-4; % Pulse repetition interval
max_range=100;% max range of radar, used to calculate antenna max width and
% azimuth reference functions


% create radar
radar=radar_object(B,T,fc,v,PRI,ant_angle);
radar=radar.get_ant_vertices(max_range);
radar=radar.get_fs(max_range);

samples=floor(radar.PRI*radar.fs);% Max no. of samples of beat signal
radar=radar.get_azimuth_reference(max_range);

azimuth_samples=3500;% samples in azimuth (related to distance covered by platform)
azimuth_distance = radar.az_step*azimuth_samples;
disp(samples)

azimuth_axis=0:radar.az_step:azimuth_distance-radar.az_step;
steps=floor(azimuth_distance / radar.az_step); % Azimuth steps

PRF=1/PRI;

rd_axis=-PRF/2:PRF/steps:PRF/2-1/PRF;

faxis=0:radar.fs/samples:radar.fs-1/radar.fs;
raxis=faxis*radar.T*radar.c/(2*radar.Beta);

%% Create targets


t1=point_target(85,floor(azimuth_distance/2));
t2=point_target(100,15);
t3=point_target(80,20);
t4=point_target(70,floor(azimuth_distance/2));
t5=point_target(75,50);
t6=point_target(70,20);
t7=point_target(20,30);
t8=point_target(80,25);
targets=[t1,t2,t3,t4,t5,t6,t7,t8];

%targets=[t4,t5];

% Determine antenna length for every target
for k=1:length(targets)
    targets(k)=targets(k).get_ant_width(ant_angle);
end

%% Display scene setup
show_scene

%% Sensing


steps=floor(azimuth_distance / radar.az_step); % Azimuth steps
t=0:1/radar.fs:1/radar.fs*samples-1/radar.fs;% Time vector of beat signal

radar.SAR_raw_data=zeros(steps,samples);% init Raw Data array

for k=1:steps

    tmp_signal=zeros(1,samples);
    for l=1:length(targets)
        illuminated=targets(l).is_illuminated(radar.y);

        if(illuminated) % Targets reflect only if illuminated
            targets(l)=targets(l).get_inst_range2(radar.x,radar.y);
            tmp_signal=tmp_signal+targets(l).get_beat(t,radar.lambda,radar.Beta,radar.T);

        else
            tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*1;% add noise
        end


    end

    radar.SAR_raw_data(k,:)=tmp_signal;

    radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
    radar=radar.get_ant_vertices(max_range);
    disp(k)


end


%% Range compression

% FFT in range direction for every pulse.
for k=1:steps
    radar.SAR_range_compressed(k,:)=fft(radar.SAR_raw_data(k,:));
    disp(k);
end
%% Range Doppler 

figure
tiledlayout(1,2)
nexttile
range_doppler=fft(radar.SAR_range_compressed,[],1);
range_doppler=fftshift(range_doppler,1);
imagesc(raxis,rd_axis,abs(range_doppler));
ylabel("PRF [Hz]")
xlabel("Range [m]")
xlim([68,73])

nexttile
imagesc(1:samples,rd_axis,abs(range_doppler));
%xlim([58,62])
%delta_R(f)=lambda^2*R*f^2/(8*v)


for k=1:length(rd_axis)
    
    f=rd_axis(k);
    %delta_R(f)=lambda^2*R*f^2/(8*v)
    delta_R(k,:)=radar.lambda^2*raxis*f^2/(8*v^2);
end




RD_corrected=range_doppler;


% for k=1:length(rd_axis)
% 
%     for l=1:length(raxis)
%         dr=delta_R(k,l);
%         fa=rd_axis(k);
%         shift_sig=exp(-1i*2*pi*dr);
%         RD_corrected(k,l)=RD_corrected(k,l).*shift_sig;
% 
% 
%     end
% end

%%
coef=radar.T*radar.c/(2*radar.Beta);
delta_f=delta_R/coef;
delta_samples=delta_f/(radar.fs/samples);
%  figure
%  plot(rd_axis,delta_samples(:,66))
%  xline(592)
%%
RD_corrected=rcmc2(range_doppler,delta_samples);
figure
tiledlayout(1,2)
nexttile
imagesc(abs(radar.SAR_range_compressed));
RD_ifft=fftshift(RD_corrected,1);
RD_ifft=ifft(RD_ifft,[],1);
nexttile
imagesc(abs(RD_ifft));


radar.SAR_range_compressed=RD_ifft;



%% Azimuth compression
% Filtering azimuth signal by azimuth reference functions.
radar=radar.azimuth_compression(samples);



%%

figure
tiledlayout(1,3)
nexttile
imagesc(0:samples-1,azimuth_axis,real(radar.SAR_raw_data));
ax = gca;
ax.YDir= 'normal';
title("Raw Data")
xlabel("Sample")
ylabel("Pulse")


nexttile
imagesc(raxis,azimuth_axis,db(abs(radar.SAR_range_compressed)));
ax = gca;
ax.YDir= 'normal';

title("Range Compressed")
% xlabel("Beat frequency [Hz]")
% ylabel("Pulse")
xlabel("Range [m]")
ylabel("Azimuth [m]")



nexttile
imagesc(real(radar.SAR_azimuth_compressed))
ax = gca;
ax.YDir= 'normal';
title("Azimuth Compressed")
colorbar
%colormap("gray")


compare_scene

% fix raxis in plots

 
%% BPA
% % for k=1:steps
% % 
% %     % BPA
% %     % Calculate position (x,y)
% %     % r=sqrt((x_radar-x_point)^2+((y_radar-y_point)^2)
% % 
% %     x=PRI*k*v; % new x coordinate for signle pulse
% %     y=R; % y is constant and does not change in time
% %     R_ap(:,k)=sqrt((x-x_p)^2+(y-y_p)^2); % BPA distance
% %     n=(R_ap-2*0)/(2*sigma_r); % Index of range cell, r_min is 0.
% %     h(:,k)=exp(1i*2*pi*R_ap(k)/lambda); % vector of filter coefficients
% %     % Define -j or +j (add some switch or smth)
% % end
% 
% radar.y=0;
% for k=1:steps
% 
%     tmp_signal=zeros(1,samples);
%     targets(1)=targets(1).get_inst_range2(radar.x,radar.y);
%     R_ap(k)=targets(1).r;
%     
%     f_base=(radar.Beta*2*targets(1).x/(T*c));
%     f_if(k)=(radar.Beta*2*targets(1).r/(T*c));
%     f_shift(k)=(radar.Beta*2*targets(1).r/(T*c))-f_base;
% 
%     samples_no(k)=round(f_if(k)/radar.fs*samples)+1;
% 
%     n=round((R_ap-2*0)/(2*radar.sigma_r));
%     h(k)=exp(1i*2*pi*R_ap(k)/radar.lambda);
% 
%     radar.SAR_raw_data(k,:)=tmp_signal;
%     radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
%     radar=radar.get_ant_vertices(max_range);
%     disp(k)
% 
% end
% 
% 
% 
% SAR_BPA=radar.SAR_range_compressed;
% for k=1:steps
% 
%     
% 
% end
% 
% % extended abstract dla prof. Misiurewicza
% % BPA w druga stronę - przeliczyć odległość na częstoliwość i ją modulować
% % jak zogniskować obraz dla celów które nie są centralnie w wiązce (RCMC?)
% % jak podzielić to co mam na komórki odległościowe? 
% % Gdzie ten doppler, jak wyciągnąć częstotliwość dopplera z sygnału
% % zdudnień?


% figure 
% imagesc(raxis,rd_axis,abs(RD_corrected));
% % ylabel("PRF [Hz]")
% % xlabel("Range [m]")



%%

%%
% for k=1:samples
%     disp(k);
% end
%     radar.SAR_azimuth_compressed=fftshift(fft2(radar.SAR_raw_data));
%
% figure
% imagesc(db(abs(radar.SAR_azimuth_compressed)))
% ax = gca;
% ax.YDir= 'normal';