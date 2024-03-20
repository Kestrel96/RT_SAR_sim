function delta_samples = delta_s(rd_axis,raxis,lambda,v,Alfa,samples,fs,c)
%DELTA_S Summary of this function goes here
%   Detailed explanation goes here
for k=1:length(rd_axis)

    f=rd_axis(k);
    coeff=lambda^2/(8*v^2)*(2*Alfa/c)*(samples/fs);
    delta_samples(k,:)=round(mean(abs(coeff*raxis*f^2)));
end
end

