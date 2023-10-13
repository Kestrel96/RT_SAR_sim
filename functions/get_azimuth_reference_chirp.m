
function azimuth_reference_LUT = get_azimuth_reference_chirp(kernel_length,swath_central_range,swath_width,ant_angle,range_resolution,v,PRI,Alfa,fc,fs)

% explain how it is done - explain matched filtering, change name from LUT,
% matched filter array 

% take mean lenght of kernel

% doppler centroids maybe shifted from 0 - maovement of platform in side
% direction -> add this to simulation


c=3e8;

%target_x=near_range
%target_y=0 always
range_axis=swath_central_range-swath_width/2:range_resolution:swath_central_range+swath_width/2-range_resolution;
LUT_rows=length(range_axis);
azimuth_step=PRI*v;
radar_positions=-kernel_length/2*azimuth_step:azimuth_step:kernel_length/2*azimuth_step-azimuth_step;



for k=1:LUT_rows
    % a1=(swath_central_range-swath_width/2)+(range_axis(k)-swath_central_range+swath_width/2);
    % tmp=a1/(swath_central_range+swath_width/2);
    % b2=kernel_length;
    % length_multiplier=a1/(swath_central_range+swath_width/2);
    % length_multiplier=1;
    % ref_length=round(length_multiplier*kernel_length);
    
    distances=sqrt(radar_positions.^2+range_axis(k).^2);
    tau=2*distances./c;
    
    lendiff=kernel_length-ref_length;
    lendiff=round(lendiff/2);
    reference=exp(2*pi*1i*(fc*tau+Alfa*tau.^2));
    reference=conj(reference);
    reference(1:lendiff)=0;
    reference(end-lendiff:end)=0;

    if mod(k,1000)==0
        plot_reim(reference);
    end
    azimuth_reference_LUT(k,:)=reference;
end



end









% function azimuth_reference_LUT = get_azimuth_reference_chirp(max_range,ant_angle,resolution,v,PRI,Alfa,fc,fs)
% %GET_AZIMUTH_REFERNCE_CHIRP Summary of this function goes here
% %   x is range
% % ant_angle in degrees







% c=3e8;

% % get range axis of given resoultion spanning to max_range
% range_axis=1:resolution:max_range;
% % Compute lenghts of ilumination of target at given distance.
% path_lengths=abs(2*range_axis*tan(deg2rad(ant_angle/2)));
% % Now get kernel lengths (how many samples for given range)
% ilumination_times=path_lengths/v;
% kernel_samples=floor(ilumination_times/PRI);

% %Allocate LUT

% max_samples=kernel_samples(end);
% LUT_rows=length(range_axis);

% %+1 because first element is length of kernel
% azimuth_reference_LUT = zeros(LUT_rows,max_samples+1);

% %d - vector of current distances at given pulse

% for k = 1:LUT_rows
%     azimuth_positions=-path_lengths(k)/2:PRI*v:path_lengths(k)/2-PRI*v;
%     d=sqrt(azimuth_positions.^2+range_axis(k).^2);
%     azimuth_reference_LUT(k,1)=kernel_samples(k);
%     % Generate reference chirp, sample for every azimuth position
%     %tau - time of flight of light. We only need one sample, not the whole reflected echo.
%     tau=2*d./c;

%     reference=exp(2*pi*1i*(fc*tau+Alfa*tau.^2));

%     azimuth_reference_LUT(k,2:length(reference)+1)=reference;

% end






% end

