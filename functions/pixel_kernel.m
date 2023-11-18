function h = pixel_kernel(distance,fc)
%PIXEL_KERNEL Summary of this function goes here
%   Detailed explanation goes here


lambda=c/fc;
c=3e8;
tau=distance/c;


phi=2*pi*fc*tau; %Jianyu Jang same as phi_n=(2*pi/lambda)*distance;
phi=(2*pi/lambda)*distance;

h=exp(1i*phi);

end

