addpath("display_scripts")
addpath("msc")
addpath("functions")
close all
clear
dbstop if error

% Radar frontend
%% Platform Parameters
c=3e8;
fc=35e9; % carrier
B=150e6; % Bandwidth
T=0.5e-3; % Chirp time
Alfa=B/T; % slope
ant_angle=5; %antenna aperture angle (default to 20)
v=50; % platform's velocity
PRI=T; % Pulse repetition interval, assume one pulse
PRF=1/PRI;
max_range=1500;% max range of radar, used to calculate antenna max width and
% azimuth reference functions


Bd=2*v/c*fc;

fb_max=max_range*2*Alfa/c;
fs=fb_max*3;
t=0:1/fs:T-1/fs;
samples=length(t);

azimuth_samples=8192;
azimuth_distance=azimuth_samples*PRI*v;
azimuth_step=azimuth_distance/azimuth_samples;

radar=radar_object(B,T,fc,v,PRI,ant_angle,fb_max);
%%Bd=2*v/radar.lambda*deg2rad(ant_angle);

%% Axes
faxis=0:fs/samples:fs-1/fs;
rd_axis=-PRF/2:PRF/azimuth_samples:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)
raxis=faxis*c*T/(2*B);
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;
sample_axis=1:1:samples;

% %% Sensing
% sensing

%% Real Data
[raw_data,params]=loadRawDataBlock("./radarData.blob","radarParameters.json");
raw_data=raw_data';
[sweeps,azimuth_samples]=size(raw_data);

%% Params

c=3e8;
fc=params.carrierFreq; % carrier
B=params.bandwidth; % Bandwidth
T=0.5e-3; % Chirp time
Alfa=B/T; % slope
ant_angle=5; %antenna aperture angle (default to 20)
v=params.averageVelocity; % platform's velocity
PRI=T; % Pulse repetition interval, assume one pulse
PRF=1/PRI;
max_range=1500;% max range of radar, used to calculate antenna max width and
% azimuth reference functions
fb_max=max_range*2*Alfa/c;


Bd=2*v/c*fc;


fs=params.samplingFreq;
t=0:1/fs:T-1/fs;
samples=length(t);

% azimuth_samples=p;
azimuth_distance=azimuth_samples*PRI*v;
azimuth_step=azimuth_distance/azimuth_samples;

radar=radar_object(B,T,fc,v,PRI,ant_angle,fb_max);
%%Bd=2*v/radar.lambda*deg2rad(ant_angle);


radar.SAR_raw_data=raw_data;

%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
display_range_compressed



















%% RCMC
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed);
delta_R=r_shift(rd_axis,raxis,radar.lambda,radar.v);


R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

shifts=round(delta_samples);
data_dump("./data/shifts.bin",shifts);

% % Range correction
RD_range_corrected=rcmc(radar.SAR_range_doppler,delta_samples);
%  Range-Doppler invert tranform
radar.SAR_range_corrected=range_doppler_invert(RD_range_corrected);
%show step results
display_range_correction

%% Azimuth compression
% close all
radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(max_range,ant_angle,1,v,PRI,Alfa,fc,fs); 
[radar.SAR_azimuth_compressed, fkernels]=azimuth_compression_freq(radar.SAR_range_corrected,radar.SAR_azimuth_reference_LUT,radar.sigma_r,1,max_range);


%show_reference_example

%% Present results
display_results
%dump_data
% export_settings(fc,B,T,Alfa,ant_angle,v,PRI,PRF,max_range);


