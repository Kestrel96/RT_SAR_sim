close all
clear

% Radar frontend
%% Platform Parameters
c=3e8;
fc=5e9; % carrier
B=25e6; % Bandwidth
T=10e-3; % Chirp time
Beta=B/T; % slope
ant_angle=60; %antenna aperture angle
v=75; % platform's velocity
PRI=4e-4; % Pulse repetition interval
max_range=300;% max range of radar, used to calculate antenna max width and
% azimuth reference functions

max_fb=Beta*2*max_range/c;
% create radar
radar=radar_object(B,T,fc,v,PRI,ant_angle,max_fb);
radar=radar.get_ant_vertices(max_range);
radar=radar.get_fs(max_range);

samples=floor(radar.PRI*radar.fs);% Max no. of samples of beat signal
radar=radar.get_azimuth_reference(max_range);

azimuth_samples=3500;% samples in azimuth (related to distance covered by platform)
azimuth_distance = radar.az_step*azimuth_samples;
disp(samples)

steps=floor(azimuth_distance / radar.az_step); % Azimuth steps

PRF=1/PRI;

%% Axes
rd_axis=-PRF/2:PRF/steps:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)
faxis=0:radar.fs/samples:radar.fs-1/radar.fs; %Frequency axis
raxis=faxis*radar.T*radar.c/(2*radar.Beta); %Frequency to range axis
azimuth_axis=0:radar.az_step:azimuth_distance-radar.az_step; %Azimuth as distance


%% Create targets


t1=point_target(100,10);
t2=point_target(90,15);
t3=point_target(80,20);
t4=point_target(70,25);
t5=point_target(10,30);
t6=point_target(70,20);
t7=point_target(20,20);
t8=point_target(80,25)
targets=[t1,t2,t3,t4,t5,t6,t7,t8];

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

        
%               tmp_signal=tmp_signal+ones(1,samples).*randn(1,samples)*1;% add noise
        end


    end

    radar.SAR_raw_data(k,:)=tmp_signal;

    radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
    radar=radar.get_ant_vertices(max_range);
    disp(k)


end

% Processing
%% Range compression
SAR_range_compressed=range_compresion(radar.SAR_raw_data,steps);


%% RCMC
% Range-Doppler transform
RD_data=range_doppler_transform(SAR_range_compressed);
delta_R=r_shift(rd_axis,raxis,radar.lambda,radar.v);

% Get shift as samples
coef=radar.T*radar.c/(2*radar.Beta);
delta_f=delta_R/coef;
delta_samples=delta_f/(radar.fs/samples);
% Range correction
RD_range_corrected=rcmc2(RD_data,delta_samples,samples);
%  Range-Doppler invert tranform
SAR_range_corrected=range_doppler_invert(RD_range_corrected);
%show step results
display_range_correction


%% Azimuth compression

%radar.SAR_rage_corrected=SAR_range_corrected;
radar.SAR_range_compressed=SAR_range_corrected;
%radar.SAR_range_compressed=SAR_range_compressed;
radar=radar.azimuth_compression(azimuth_samples);

%% Display
display_results
display_scene_comparison
dump_data


