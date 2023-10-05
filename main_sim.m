%% Environment Init
clear
addpath("display_scripts")
addpath("msc")
addpath("functions")
close all
clear
dbstop if error

% Radar frontend
% load params from struct
params = loadStructFromJson("./radarParameters.json");

%% Platform Parameters
c=3e8;
fc=params.carrierFreq; % carrier
B=params.bandwidth; % Bandwidth
T=1/params.sweepsPerSecond; % Chirp time
Alfa=B/T; % slope
ant_angle=5; %antenna aperture angle (default to 20)
v=params.averageVelocity; % platform's velocity
central_swath_range=params.centralSwathRange;
PRI=T; % Pulse repetition interval, assume one pulse
PRF=1/PRI;
fs=params.samplingFreq;
radar=radar_object(B,T,fc,v,PRI,ant_angle,1000);

% c=3e8;
% fc=9.6e9; % carrier
% B=260e6; % Bandwidth
% T=1e-3; % Chirp time
% Alfa=B/T; % slope
% ant_angle=5; %antenna aperture angle (default to 20)
% v=30; % platform's velocity
% central_swath_range=params.centralSwathRange;
% PRI=T; % Pulse repetition interval, assume one pulse
% PRF=1/PRI;
% fs=params.samplingFreq;
% radar=radar_object(B,T,fc,v,PRI,ant_angle,1000);

%% Simulation setup
sweeps=15000; %samples in azimuth
azimuth_samples=sweeps; %rename in sensing script later150
azimuth_distance=sweeps*T*v;
samples=params.samplesPerSweep; %samples in range
range_samples=samples;%rename in sensing script later
% Axes
NRange=samples;
rangeAxis = (-(NRange) / 2 : ( (NRange ) / 2) - 1) * c / (2 * B);
rangeAxis=rangeAxis+params.centralSwathRange;


azimuth_step=T*v;
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;

%% Sensing
% x is range, y is azimuth
csr=central_swath_range;
t1=point_target(csr+100,100);
t2=point_target(csr-200,200);
targets=[t1,t2];
sensing

display_raw



%% Radar processing
%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
 display_range_compressed

















% %% Axes
% %beat=exp(2*pi*1i*(fc*tau+Alfa*tau*t-(Alfa*tau^2/2)));
% f_step=fs/samples;
% faxis=0:fs/samples:fs-1/fs;
% raxis=faxis*c*T/(2*B);
% NRange=samples;
% rangeAxis = (-(NRange) / 2 : ( (NRange ) / 2) - 1) * c / (2 * B);
%
%
% rd_axis=-PRF/2:PRF/azimuth_samples:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)
%
% azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;
% sample_axis=1:1:samples;
%
%




