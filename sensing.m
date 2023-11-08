
%% Radar frontend

% Setup of frontend of collected data
% Radar frontend samples data at very high sampling frequency. 
% This signal is later demodulated to baseband and decimated to match the last ADC 
% sampling frequency.

% Determine maximum frequency that is expected to be recorded,
% based on that determine frontend sampling frequency and decimation factor for
% raw data ADC.
max_f=dist2freq(params.centralSwathRange+params.swathWidth/2,Alfa);
dec_factor=ceil(max_f/(params.samplingFreq/2));
frontend_fs=dec_factor*params.samplingFreq;
% Number of samples must be `dec_factor` times bigger than raw data samples.
frontend_samples=params.samplesPerSweep*dec_factor;
% Prepare time vector for simulation
t=linspace(1,frontend_samples,frontend_samples);
t=t*1/frontend_fs;

% Prepare signal for demodulation. This is a sine with frequency corresponding to central swath range.
tau=2*params.centralSwathRange/c;
f_csr=dist2freq(params.centralSwathRange,Alfa);
csr_signal=exp(-2*pi*1i*t*f_csr);


%% Initalizations
radar.SAR_frontend_out=zeros(azimuth_samples,frontend_samples);
radar.SAR_raw_data=zeros(azimuth_samples,range_samples);% init Raw Data array
max_range=csr+params.swathWidth/2;
radar=radar.get_ant_vertices(max_range);
noise_mult=0;


fprintf("Sensing\n");
load("fNum.mat");
%% Sensing

for k=1:length(targets)
    targets(k)=targets(k).get_ant_width(ant_angle);
end


for k=1:azimuth_samples

    tmp_signal=zeros(1,frontend_samples);
    noise=noise_mult*randn(1,frontend_samples);
    for l=1:length(targets)

        illuminated=targets(l).is_illuminated(radar.y);
        tmp_signal=tmp_signal+noise;
        if illuminated
            fb=targets(l).get_fb(radar.y,Alfa);
            beat=targets(l).get_beat(radar.y,Alfa,t,fc);
            %beat=filter(fNum,1,beat);
            tmp_signal=tmp_signal+beat;

        end
   

    end

    radar.SAR_frontend_out(k,:)=tmp_signal;

    radar.y=radar.y+radar.az_step;% move the platform, recalculate antenna
    radar=radar.get_ant_vertices(max_range);
    progress_bar(k,128,2048,azimuth_samples,"step");

end
fprintf("\n");


%% Demodulation, LP filter, Decimation
fprintf("DDC\n");
for k=1:azimuth_samples

    % Move signal to baseband...
    radar.SAR_frontend_out(k,:)=radar.SAR_frontend_out(k,:).*csr_signal;
    % ... and decimate with LP
    radar.SAR_raw_data(k,:)=decimate(radar.SAR_frontend_out(k,:),dec_factor,"fir");

    progress_bar(k,128,2048,azimuth_samples,"ddc step");

end
fprintf("\n");



