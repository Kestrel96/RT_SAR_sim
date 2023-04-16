close all
clear

%% Radar setup
c=3e8;
fc=4e9; % carrier
B=25e6; % Bandwidth
T=5e-3; % Chirp time
Beta=B/T; % slope
lambda=c/fc;
ant_angle=deg2rad(30); % antenna beam angle


delta_R=c/2/B; %range resoultion
delta_fz=1/T; %frequency resolution (?)

% alt = 400m
% sigma_r=~ 2m


%% Platform Setup
% All parameters are dependent on pulses in azimuth
R=10;
L=2*R*tan(ant_angle); % Length of antenna footprint on the ground
sigma_a=L/2; % azimuth resolution
sigma_r=c/(2*B);% range resolution

pulses = 1000; % pulses during target ilumination
v=10; % platform velocity
time=L/v; % time of ilumination

PRI=time/pulses;
PRF=1/PRI;


f0=Beta*2*R/(T*c); % Frequency of beat signal from target (used to calculate sampling freq)
phi=4*pi*R/lambda; % Phase shift

fs=f0*5; % ADC sampling - at least 2 times higher than highest beat frequency
step=PRI*v; % distance traveled by platform in one PRI

d_max=fs*c/(2*Beta);


%t=0:1/fs:0.001*PRI*fs-1/fs;

%samples=100; % Amount of samples (in range) of beat signal

samples=floor(fs*PRI);

t=0:1/fs:1/fs*samples-1/fs;

range_cells=0:sigma_r:sigma_r*samples;
azimuth_cells=0:sigma_a:sigma_a*pulses;

% Preallocate SAR memory
SAR_raw=zeros(int32(pulses),length(t));
SAR_range_compressed=zeros(int32(pulses),length(t));
SAR_range_corrected = zeros(int32(pulses),length(t));

% t=2*d/c;
%d=f0*T*c/(2*Beta);


% BPA - point coordinates
% point coordinates:
x_p=L/2;
y_p=0;

% Preallocate memory for R_ap and filter response
R_ap=zeros(1,int32(pulses));
h=zeros(1,int32(pulses));

%% Sensing
for k=1:pulses
    % Calculate distance
    r=sqrt(R^2+(L/2-step*k)^2);

    % Receive echo (get beat)

    %SAR_raw(k,:)=get_beat(r,t,lambda,Beta,T)+randn(1,length(t));
    SAR_raw(k,:)=get_beat(r,t,lambda,Beta,T);



   

    

end




%% Range compression

faxis=0:fs/samples:fs-fs/samples;

for k=1:pulses
    SAR_range_compressed(k,:)=fft(SAR_raw(k,:));
    SAR_range_corrected(k,:)=rcmc(SAR_raw(k,:),f0,faxis,t);




end

% Edn simulation


% Remake as function
% Iterate through all pixels 
% Check range resolution, fix axis and range cells. 
%% BPA
for k=1:pulses

     % BPA
    % Calculate position (x,y)
    % r=sqrt((x_radar-x_point)^2+((y_radar-y_point)^2)
    
    x=PRI*k*v; % new x coordinate for signle pulse
    y=R; % y is constant and does not change in time
    R_ap(:,k)=sqrt((x-x_p)^2+(y-y_p)^2); % BPA distance
    n=(R_ap-2*0)/(2*sigma_r); % Index of range cell, r_min is 0.
    h(:,k)=exp(1i*2*pi*R_ap(k)/lambda); % vector of filter coefficients
    % Define -j or +j (add some switch or smth)
end

%% RCMC

%% Azimuth



% for k=1:samples
%     SAR_rd(:,k)=fft(SAR_range_compressed(:,k));
% end
% 
% figure
% imagesc(SAR_rd);

%% Display Data
display_data

%%

figure

plot(real(SAR_range_corrected(:,78)));



%%

%  figure
%  ind=700;
%  tiledlayout(3,1)
%  nexttile
%  faxis=0:fs/samples:fs-fs/samples;
%  raxis=faxis*T*c/(2*Beta);
%  plot(faxis,abs(SAR_range_compressed(ind,:)))
%  xlabel("IF [Hz]")
%  title("Frequency domain")
%  nexttile
%  plot(raxis,abs(SAR_range_compressed(ind,:)))
%  xlabel("Slant range [m]")
%  title("Range domain")
%  nexttile
%  [~,mind]=max(abs(SAR_range_compressed(ind,:)));
%  If=faxis(mind);
%  f_diff=abs(f0-If);
%  r0=If*T*c/(2*Beta);
%  r_diff=R+r0;
%  f_mod=Beta*2*r_diff/(T*c);
%  r_corr=(If-f_diff)*T*c/(2*Beta);



%%
% close all
% clear
% f0=1.5e4;
% tc=1/f0;
% fs=3*f0;
% t=0:1/fs:1/fs*1000-1/fs;
% % figure
% tmp=exp(i*(2*pi*f0*t));
% %tmp=cos(2*pi*f0*t);
% plot(real(tmp(1:100)))



% zdecydowanie poniżej kilometra
% splot w częstotliwości ?
% przypomnij sobi eoblinaie splotu, fft















% delta f = 2dv/c*f_0
