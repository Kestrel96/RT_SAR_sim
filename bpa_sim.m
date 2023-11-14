%% Environment Init
clear
colormap jet
close all
addpath("display_scripts")
addpath("msc")
addpath("functions")


clear
dbstop if error




%% Platform Parameters
params = loadStructFromJson("./radarParameters.json");
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
sweeps=5000; %samples in azimuth
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
raxis_csr=raxis+params.centralSwathRange;
raxis=raxis+params.centralSwathRange;
rd_axis=-PRF/2:PRF/azimuth_samples:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)

azimuth_step=T*v;
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;


D=radar.lambda/ant_angle;
dr=0.25;
da=0.25;

%% Sensing
% x is range, y is azimuth
csr=central_swath_range;
t1=point_target(csr+50,100);
t2=point_target(csr-100,100);
t3=point_target(csr,100);
t4=point_target(csr,20);
t5=point_target(csr-15,45);
targets=[t1,t2,t3,t4,t5];
sensing


%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
display_range_compressed

%% BPA


% Create grid (center of pixel , every pixel is a number, simple value)
sar_image=zeros();

% For every pixel:
%   Get echo from given radar positon
%   Take samples that span across a resolution unit - 0,25 m = 
%   Filter it with matched filter
%   Sum it with previous echoes


























