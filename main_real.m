%% Environment Init
clear
close all
addpath("display_scripts")
addpath("msc")
addpath("functions")

clear
dbstop if error


%% Load Real Data
[raw_data,params]=loadRawDataBlock("./radarData.blob","radarParameters.json");
% matlab stores data column wise - do not transpose
raw_data=raw_data';
[sweeps,samples]=size(raw_data);


%% Platform Parameters
%params = loadStructFromJson("./radarParameters.json");
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
%sweeps=10000; %samples in azimuth
azimuth_samples=sweeps; %rename in sensing script later150
azimuth_distance=sweeps*T*v;
%samples=params.samplesPerSweep; %samples in range
range_samples=samples;%rename in sensing script later
% Axes
NRange=samples;
sigma_r=c/(2*B);
rangeAxis = (-(NRange) / 2 : ( (NRange ) / 2) - 1) *sigma_r; %hmmmm?
%rangeAxis=rangeAxis+central_swath_range;


faxis=-fs/2:fs/samples:fs/2-fs/samples;
raxis=freq2dist(faxis,Alfa);
raxis_csr=raxis+params.centralSwathRange;
rd_axis=-PRF/2:PRF/azimuth_samples:PRF/2-1/PRF; %Range-Doppler domain axis (azimuth as frequency)

azimuth_step=T*v;
azimuth_axis=0:azimuth_step:azimuth_distance-azimuth_step;


%% Radar processing
radar.SAR_raw_data=zeros(sweeps,samples);
radar.SAR_raw_data=raw_data;
%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data);
display_range_compressed

%% Range doppler
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed);
display_range_doppler

%% RCMC
delta_R=r_shift(rd_axis,raxis_csr,radar.lambda,radar.v);


R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

shifts=round(delta_samples);
%data_dump("./data/shifts.bin",shifts);

% % Range correction
RD_range_corrected=rcmc(radar.SAR_range_doppler,delta_samples);
%  Range-Doppler invert tranform
radar.SAR_range_corrected=range_doppler_invert(RD_range_corrected);




%show step results
display_range_correction

%% Azimuth Compression

radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(5000,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs);
[radar.SAR_azimuth_compressed, freq_kernels] = azimuth_compression(radar.SAR_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);

display_azimuth_compressed;





