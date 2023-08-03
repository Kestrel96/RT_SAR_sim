function shifted = fftshift_custom(fft_input)
%FFTSHIFT_CUSOTM Summary of this function goes here
%   Detailed explanation goes here



fft_size = length(fft_input);
shifted=zeros(1,fft_size);

if mod(fft_size,2)==0
    shifted(fft_size/2+1:end)=fft_input(1:fft_size/2);
    shifted(1:fft_size/2)=fft_input(fft_size/2+1:end);
end
end

