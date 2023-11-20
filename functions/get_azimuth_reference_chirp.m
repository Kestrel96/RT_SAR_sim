
function azimuth_reference_LUT = get_azimuth_reference_chirp(kernel_length,swath_central_range,swath_width,ant_angle,range_resolution,v,PRI,Alfa,fc,fs,conjugate)

% explain how it is done - explain matched filtering, change name from LUT,
% matched filter array

% take mean lenght of kernel

% doppler centroids maybe shifted from 0 - maovement of platform in side
% direction -> add this to simulation


c=3e8;

% Prepare range axis
range_axis=swath_central_range-swath_width/2:range_resolution:swath_central_range+swath_width/2-range_resolution;
%range_axis=-swath_width/2:range_resolution:+swath_width/2-range_resolution;

% Initialize array
LUT_rows=length(range_axis);
azimuth_step=PRI*v;

% Radar azimuth positions vector - used to calculate slant range.
radar_positions=-kernel_length/2*azimuth_step:azimuth_step:kernel_length/2*azimuth_step-azimuth_step;



azimuth_reference_LUT=zeros(LUT_rows,kernel_length);
for k=1:LUT_rows
    
    %vector of distances to radar
    distances=sqrt(radar_positions.^2+range_axis(k).^2);
    % vector o delays (time of flight)
    tau=2*distances./c;


    % Old formula (will be deleted)
    %      reference=exp(2*pi*1i*(fc*tau+Alfa*tau.^2));
    %      reference=conj(reference);
    %azimuth_reference_LUT(k,:)=reference;

    % Calculate azimuth ref signal.
    lambda=0.0086;
    ref2=exp(1i*2*pi*(2*(distances-range_axis(k))/lambda));
    %ref2=fliplr(ref2); % another formula, more acurate from WAT paper.
    if conjugate == true
        ref2=conj(ref2);
    end
    azimuth_reference_LUT(k,:)=ref2;


    progress_bar(k,40,400,LUT_rows,"Azimuth Ref")


end
fprintf("\n")


end









% function azimuth_reference_LUT = get_azimuth_reference_chirp(max_range,ant_angle,resolution,v,PRI,Alfa,fc,fs)
% %GET_AZIMUTH_REFERNCE_CHIRP Summary of this function goes here
% %   x is range
% % ant_angle in degrees








