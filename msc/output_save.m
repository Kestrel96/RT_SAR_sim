close all
clear
fs=10e3;
f=1.5e3;
t=0:1/fs:0.01-1/fs;
x=exp(1i*2*pi*f*t);
plot(real(x));


%% fft
X=fft(x);

figure
stem(real(X));



%% export
% rel_val=zeros(1,length(x));
% im_val=zeros(1,length(x));
% 
% 
% rel_val=round(real(x),6);
% im_val=round(imag(x),6);
% 
% FID = fopen('x.h', 'w');
% if FID == -1, error('Cannot create file.'); end
% fprintf(FID,"float x_real[%u] = {\n",length(x));
% fprintf(FID, '%g, %g, %g, %g,\n', rel_val);
% fprintf(FID,"};\n");
% 
% fprintf(FID,"float x_imag[%u] = {\n",length(x));
% fprintf(FID, '%g, %g, %g, %g,\n', im_val);
% fprintf(FID,"};\n");
% fclose(FID);


%% export2

r=real(x);

f= fopen('signal.bin','wb');
fwrite(f,[length(x)],'int');
fwrite(f,real(x),'single');
%fwrite(f,imag(x),'single');
fclose(f);

