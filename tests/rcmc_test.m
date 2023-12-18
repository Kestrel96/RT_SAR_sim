% using namespace std;
% float dr = freq2dist(cfg.fs / cfg.samples, cfg.alfa);
% float r = dr * static_cast<float>(range_sample_no);
% float fd = static_cast<float>(sweep_no) * cfg.PRF / cfg.sweeps - PRF/2;
%
% float tmp = 2 * cfg.alfa * pow(cfg.lambda, 2) * r * pow(fd, 2) * cfg.sweeps / (8 * cfg.c * pow(cfg.v, 2) * cfg.fs);
%
% return static_cast<uint>(tmp);


%23.704463246261053

sweep_no=1;
sample_no=736;


B=params.bandwidth; % Bandwidth
T=1/params.sweepsPerSecond; % Chirp time
Alfa=B/T; % slope


dr=freq2dist(fs/samples,Alfa);
r_start=freq2dist(-fs/2,Alfa);
r = params.centralSwathRange+r_start  +  dr*sample_no;


fd=sweep_no*PRF/sweeps - PRF/2;
delta_r=(radar.lambda^2*r*fd^2)/(8*v^2);

tmp=dist2freq(delta_r,Alfa)*samples/fs;



tmp=2*Alfa*radar.lambda^2*r*fd^2*samples/(8*c*v^2*params.samplingFreq)
round(tmp)
round(delta_samples(sweep_no,sample_no))