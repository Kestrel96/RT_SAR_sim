close all
addpath("../functions")

close all
clear
fs=1e3;
f=2e2;
f2=f/2;
t=0:1/fs:0.01-1/fs;
x=exp(1i*2*pi*f*t);
x2=exp(1i*2*pi*f2*t);
x=x+x2;

faxis=0:fs/length(t):fs-fs/length(t);
faxis=faxis-fs/2;


batch=zeros(4,10);
for i=1:4
    x=exp(1i*2*pi*f*t+pi/6*i);
    batch(i,:)=x;
end


X=fft(batch,[],1);


figure
tiledlayout(1,2)
nexttile
imagesc(abs(X));
nexttile
stem(faxis,real(X(1,:)));

data_dump("./batch.bin",batch);