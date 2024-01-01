%% Environment Init

clear

close all
addpath("display_scripts")
addpath("msc")
addpath("functions")

clear
dbstop if error

suffix="real";

%% Load Real Data
[raw_data,params]=loadRawDataBlock("./radarData.blob","radarParameters.json");
raw_data=raw_data.';
[sweeps,samples]=size(raw_data);

% raw_data=raw_data(1:sweeps/2,1:samples);

%% Platform Parameters
%params = loadStructFromJson("./radarParameters.json");
c=3e8;
fc=params.carrierFreq; % carrier
B=params.bandwidth; % Bandwidth
T=1/params.sweepsPerSecond; % Chirp time
Alfa=B/T; % slope
ant_angle=5; %antenna aperture angle (default to 20)

% override
v=params.averageVelocity; % platform's velocity
%v=28

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
radar.SAR_range_compressed=range_compression(radar.SAR_raw_data,false);
display_range_compressed

close all
% Unti here the same as simulation
%% Range doppler
radar.SAR_range_doppler=range_doppler_transform(radar.SAR_range_compressed,false);
display_range_doppler
close all
%% RCMC
delta_R=r_shift(rd_axis,raxis_csr,radar.lambda,radar.v);


R_to_f=2*delta_R*Alfa/c;
delta_samples=R_to_f*samples/fs;

shifts=zeros(sweeps,1);
shifts2=zeros(sweeps,1);
for k=1:sweeps
shifts2(k,1)=mean(delta_samples(k,:));
shifts(k,1)=round(mean(delta_samples(k,:)));
end
figure
plot(shifts,"x")
hold on
plot(shifts2,LineWidth=3)

data_dump("../RT_SAR_CUDA/data/inputs/shifts_real.bin",shifts);
%%
% % Range correction
RD_range_corrected=rcmc(radar.SAR_range_doppler,delta_samples);
%  Range-Doppler invert tranform
% radar.SAR_range_corrected=range_doppler_invert(RD_range_corrected);


%show step results
display_range_correction
close all


%% Azimuth Compression

radar.SAR_azimuth_reference_LUT=get_azimuth_reference_chirp(1500,params.centralSwathRange,params.swathWidth,ant_angle,sigma_r,v,PRI,Alfa,fc,fs,true);
[azimuth_compressed, freq_kernels] = azimuth_compression(RD_range_corrected,radar.SAR_azimuth_reference_LUT,sigma_r,sigma_r,params.centralSwathRange+params.swathWidth/2);

radar.SAR_azimuth_compressed=range_doppler_invert(azimuth_compressed);

dump_array("../RT_SAR_CUDA/data/inputs/frequency_kernels_real.bin",1000*freq_kernels.');
dump_array("../RT_SAR_CUDA/data/inputs/raw_data_real.bin",radar.SAR_raw_data);


% clear raw_data
% clear delta_samples
% clear RD_range_corrected
% clear shifts
% clear delta_R


display_azimuth_compressed;



%% TODOS:
% - fix simulation to be compatible with real data
% - add comments
% - move focused version to CUDA



