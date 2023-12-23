%% Environment Init
clear

addpath("display_scripts")
addpath("msc")
addpath("tests")
addpath("functions")
colormap jet
close all
clear
dbstop if error

suffix="sim";




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
sweeps=10000; %samples in azimuth
azimuth_samples=sweeps; %rename in sensing script later
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

%display_raw


%% Radar processing
%% Range compression
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data,false);
%%
display_range_compressed
close all

%% Range doppler

% Tehre should be no fftshift here
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed,true);
display_range_doppler
close all
%% RCMC
delta_R=r_shift(rd_axis,raxis_csr,radar.lambda,radar.v);


R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

%shift SHIFTS instead
%%
shifts=zeros(sweeps,1);
shifts2=zeros(sweeps,1);
for k=1:sweeps
shifts2(k,1)=mean(delta_samples(k,:));
shifts(k,1)=round(mean(delta_samples(k,:)));
end
%%
figure
plot(shifts,"x")
hold on
plot(shifts2,LineWidth=3)
%%
data_dump("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/inputs/shifts_sim.bin",shifts);

% % Range correction
RD_range_corrected=rcmc(radar.SAR_range_doppler,delta_samples);
%  Range-Doppler invert tranform
radar.SAR_range_corrected=range_doppler_invert(RD_range_corrected);


clear delta_samples

clear delta_R

%show step results
display_range_correction
close all
%%
clear RD_range_corrected

%% Azimuth Compression

radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(2000,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs,true);
[radar.SAR_azimuth_compressed, freq_kernels] = azimuth_compression(radar.SAR_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);
dump_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/inputs/frequency_kernels_sim.bin",freq_kernels);
dump_array("/home/kuba/Desktop/RT_SAR/RT_SAR_CUDA/data/inputs/raw_data_sim.bin",radar.SAR_raw_data);

%%
display_azimuth_compressed;


close all



