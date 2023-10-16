
%% Radar frontend

% Setup of frontend of collected data
max_f=dist2freq(params.centralSwathRange+params.swathWidth/2,Alfa);
dec_factor=ceil(max_f/(params.samplingFreq/2));

frontend_fs=dec_factor*params.samplingFreq;
frontend_samples=params.samplesPerSweep*dec_factor;
t=linspace(1,frontend_samples,frontend_samples);
t=t*1/frontend_fs;

tau=2*params.centralSwathRange/c;
f_csr=dist2freq(params.centralSwathRange,Alfa);
csr_signal=exp(-2*pi*1i*t*f_csr);







%% Initalizations
radar.SAR_frontend_out=zeros(azimuth_samples,frontend_samples);
radar.SAR_raw_data=zeros(azimuth_samples,range_samples);% init Raw Data array
max_range=csr+params.swathWidth/2;
radar=radar.get_ant_vertices(max_range);
noise_mult=1;



% register far data
% modulate and lowpass
% decimate

fprintf("Sensing\n");
load("fNum.mat");
%%
for k=1:azimuth_samples

    tmp_signal=zeros(1,frontend_samples);
    for l=1:length(targets)

        illuminated=targets(l).is_illuminated(radar.y);


        fb=targets(l).get_fb(radar.y,Alfa);
        beat=targets(l).get_beat(radar.y,Alfa,t,fc);
        %beat=filter(fNum,1,beat);
        tmp_signal=tmp_signal+beat;

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

    radar.SAR_frontend_out(k,:)=radar.SAR_frontend_out(k,:).*csr_signal;
    radar.SAR_raw_data(k,:)=decimate(radar.SAR_frontend_out(k,:),dec_factor,"fir");
    

    progress_bar(k,128,2048,azimuth_samples,"ddc step");

end
fprintf("\n");



