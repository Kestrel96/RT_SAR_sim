function distance = get_distance(radar_x,radar_y,pixel_x,pixel_y)
%GET_DISTANCE Summary of this function goes here
%   Detailed explanation goes here

    
    distance = sqrt((radar_x-pixel_x)^2 + (radar_y+pixel_y)^2);


    
end

