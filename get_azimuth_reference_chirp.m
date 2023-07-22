function azimuth_reference_LUT = get_azimuth_reference_chirp(max_range,ant_angle,resolution,v,PRI,Alfa,fc,fs)
%GET_AZIMUTH_REFERNCE_CHIRP Summary of this function goes here
%   x is range
% ant_angle in degrees

c=3e8;

% get range axis of given resoultion spanning to max_range
range_axis=1:resolution:max_range;
% Compute lenghts of ilumination of target at given distance.
path_lengths=abs(2*range_axis*tan(deg2rad(ant_angle/2)));
% Now get kernel lengths (how many samples for given range)
ilumination_times=path_lengths/v;
kernel_samples=floor(ilumination_times/PRI);

%Allocate LUT

max_samples=kernel_samples(end);
LUT_rows=length(range_axis);

%+1 because first element is length of kernel
azimuth_reference_LUT = zeros(LUT_rows,max_samples+1);

%d - vector of current distances at given pulse

for k = 1:LUT_rows
    azimuth_positions=-path_lengths(k)/2:PRI*v:path_lengths(k)/2-PRI*v;
    d=sqrt(azimuth_positions.^2+range_axis(k).^2);
    azimuth_reference_LUT(k,1)=kernel_samples(k);
    % Generate reference chirp, sample for every azimuth position
    %tau - time of flight of light. We only need one sample, not the whole reflected echo.
    tau=2*d./c;

    reference=exp(2*pi*1i*(fc*tau+Alfa*tau.^2));

azimuth_reference_LUT(k,2:length(reference)+1)=reference;

end






end

