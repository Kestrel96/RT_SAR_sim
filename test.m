% 
% close all
% fs=10000;
% f=100;
% t=0:1/fs:1-1/fs;
% emod=exp(1i*2*pi*50*t);
% x=exp(1i*2*pi*f*t);
% x=x.*emod;
% 
% x2=exp(1i*2*pi*200*t);
% 
% x=x+x2;
% figure 
% plot(real(x(1:1000)))
% X=fft(x);
% figure;
% plot(abs(X))
% 
% faxis=0:length(t)*1/fs:fs-1/fs;
% figure 
% emod2=exp(1i*2*pi*50*faxis);
% X=X.*emod2;
% plot(faxis,abs(X));







