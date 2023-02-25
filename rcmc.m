function [corrected_range_compressed,f_diff] = rcmc(SAR_raw,f0,faxis,t)
%RCMC Summary of this function goes here
%   Detailed explanation goes here
[~,mind]=max(abs(fft(SAR_raw)));
If=faxis(mind);
f_diff=abs(f0-If);
%r0=If*T*c/(2*Beta);
%r_diff=abs(R-r0);
% f_mod=Beta*2*r_diff/(T*c);
% r_corr=(If-f_diff)*T*c/(2*Beta);

corrected_range_compressed = fft(SAR_raw .* exp(-1i*2*pi*f_diff*t));

end

