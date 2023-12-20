
close all
load LUT

fs=10e3;
f=5e3;
t=0:1/fs:0.01-1/fs;
samples=length(t);
x=exp(1i*2*pi*f*t);

faxis=0:fs/length(t):fs-fs/samples;




X=fft(x)/length(t);



range_position=15*0.2778;
radar_azimuth_position=azimuth_step*10;


azimuth_steps

distance=sqrt(radar_azimuth_position.^2+range_position.^2);

lambda=0.086;

ref_f=(2*(distance-range_position)/lambda);

ref2=exp(1i*2*pi*f);
plot_reim(A(5,:));