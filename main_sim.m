%% Environment Init
clear
close all
addpath("display_scripts")
addpath("msc")
addpath("functions")

clear
dbstop if error

% Radar frontend
% load params from struct
params = loadStructFromJson("./radarParameters.json");



% range axis, which one is good?

%%
%ddc is like modulation - modulating sine is equivalent to central swath
% range
% range frequency
%beamwidth such that ther is no aliasing (5 deg for first try)
%

%% Platform Parameters
params.centralSwathRange=1000;

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
%fs=15000000;
radar=radar_object(B,T,fc,v,PRI,ant_angle,1000);


%% Simulation setup
sweeps=10000; %samples in azimuth
azimuth_samples=sweeps; %rename in sensing script later150
azimuth_distance=sweeps*T*v;
samples=params.samplesPerSweep; %samples in range
range_samples=samples;%rename in sensing script later
% Axes
NRange=samples;
sigma_r=c/(2*B);
rangeAxis = (-(NRange) / 2 : ( (NRange ) / 2) - 1) *sigma_r; %hmmmm?
%rangeAxis=rangeAxis+central_swath_range;


faxis=-fs/2:fs/samples:fs/2-fs/samples;
raxis=freq2dist(faxis,Alfa);


%%
azimuth_step=T*v;
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;

%% Sensing
% x is range, y is azimuth
csr=central_swath_range;
t1=point_target(csr+50,100);
t2=point_target(csr-100,100);
t3=point_target(csr,100);
t4=point_target(csr,20);
targets=[t1,t2,t3,t4];
sensing

%display_raw


%% Radar processing
%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
display_range_compressed

%% Range doppler
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed);
display_range_doppler






