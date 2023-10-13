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



% axis - negative and positive side
% beat ferquency - is too high with given parameters
% aliasing in range doppler domain - what to do?
% how to get rid of too high beat frequency when target is very far

%%
%ddc is like modulation - modulating sine is equivalent to central swath
% range
%range frequency
%beamwidth such that ther is no aliasing (5 deg for first try)
%

%% Platform Parameters
c=3e8;
fc=params.carrierFreq; % carrier
B=params.bandwidth; % Bandwidth
T=1/params.sweepsPerSecond; % Chirp time
Alfa=B/T; % slope
ant_angle=5; %antenna aperture angle (default to 20)
v=params.averageVelocity; % platform's velocity
central_swath_range=1000;
PRI=T; % Pulse repetition interval, assume one pulse
PRF=1/PRI;
fs=params.samplingFreq;
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
rangeAxis = (-(NRange) / 2 : ( (NRange ) / 2) - 1) *sigma_r;
rangeAxis=rangeAxis+central_swath_range;


faxis=-fs/2:fs/samples:fs/2-fs/samples;
%faxis=0:fs/samples:fs-fs/samples;
raxis=freq2dist(faxis,Alfa);


%%
azimuth_step=T*v;
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;

%% Sensing
% x is range, y is azimuth
csr=central_swath_range;
t1=point_target(csr+300,100);
t2=point_target(csr,100);
t3=point_target(csr+100,100);
targets=[t1];
sensing

%display_raw


%% Radar processing
%% DDC
%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
display_range_compressed

%% Range doppler
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed);
display_range_doppler



%% 





 % x=exp(2*pi*1i*(1e6*t));
 % plot_signal(faxis,radar.SAR_raw_data(5000,:));
 % 
 % plot_signal(x,faxis);





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




