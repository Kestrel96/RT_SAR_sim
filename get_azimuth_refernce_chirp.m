function azimuth_reference_LUT = get_azimuth_refernce_chirp(v,PRI,max_range,pulses,ant_angle)
%GET_AZIMUTH_REFERNCE_CHIRP Summary of this function goes here
%   x is range


azimuth_reference_LUT=zeros(max_range,pulses);

angle=deg2rad(ant_angle);


% Range reference with 1 m intervals between targets
for r=1:max_range

    antenna_width = 2*r*tan(angle/2);
    floor(antenna_width)
    
    for k=1:antenna_width
    end
    

    phase_shifts=4*pi*r/lambda;
    reference=exp(1i*(phase_shifts));
end




end

