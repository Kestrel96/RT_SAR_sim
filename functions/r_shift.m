function delta_R = r_shift(rd_axis,raxis,lambda,v)
%R_SHIFT Summary of this function goes here
%   Detailed explanation goes here


delta_R=zeros(length(rd_axis),length(raxis));
for k=1:length(rd_axis)
    
    f=rd_axis(k);
    %delta_R(f)=lambda^2*R*f^2/(8*v)
    delta_R(k,:)=lambda^2*raxis*f^2/(8*v^2);
end
end

