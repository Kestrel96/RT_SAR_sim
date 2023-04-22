addpath("display_scripts")
addpath("functions")
close all
clear

% Radar frontend
%% Platform Parameters
c=3e8;
fc=1e9; % carrier
B=75e6; % Bandwidth
T=1e-3; % Chirp time
Alfa=B/T; % slope
ant_angle=60; %antenna aperture angle
v=50; % platform's velocity
PRI=T; % Pulse repetition interval, assume one pulse
PRF=1/PRI;
max_range=250;% max range of radar, used to calculate antenna max width and
% azimuth reference functions


Bd=2*v/c*fc;

fb_max=max_range*2*Alfa/c;
fs=fb_max*3;
t=0:1/fs:T-1/fs;
samples=length(t);

azimuth_samples=2000;
azimuth_distance=azimuth_samples*PRI*v;
azimuth_step=azimuth_distance/azimuth_samples;

radar=radar_object(B,T,fc,v,PRI,ant_angle,fb_max);
%%Bd=2*v/radar.lambda*deg2rad(ant_angle);

%% Targets

t1=point_target(25,45);
t2=point_target(120,15);
t3=point_target(120,azimuth_distance/2);
t4=point_target(230,15);
t5=point_target(124,15);

targets=[t1,t2,t3,t4,t5];


% Determine antenna length for every target
for k=1:length(targets)
    targets(k)=targets(k).get_ant_width(ant_angle);
end

%% Axes
faxis=0:fs/samples:fs-1/fs;
rd_axis=-PRF/2:PRF/azimuth_samples:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)
raxis=faxis*c*T/(2*B);
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;
sample_axis=1:1:samples;
show_scene
%% Sensing
sensing

%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);

%% RCMC
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed);
delta_R=r_shift(rd_axis,raxis,radar.lambda,radar.v);

R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

% % Range correction
RD_range_corrected=rcmc3(radar.SAR_range_doppler,delta_samples);
%  Range-Doppler invert tranform
radar.SAR_range_corrected=range_doppler_invert(RD_range_corrected);
%show step results
display_range_correction

%% Azimuth compression
LUT=get_azimuth_reference(azimuth_axis,raxis,fc,Alfa); 
radar.SAR_azimuth_compressed=azimuth_compression(radar.SAR_range_corrected,LUT);
show_reference_example

%% Present results
display_results
