function SAR_img = bpa(SAR_range_compressed,azimuth_axis,image_size_x,image_size_y,min_x,min_y,max_x,max_y,dx,dy)
%UNTITLED Summary of this function goes here
%   x - range (fast time)
%   y - azimuth (slow time)

SAR_img=[];

pixels=zeros(image_size_y,image_size_x);
pixels_x_postions=min_x:dx:max_x;
pixels_y_positions=min_y:dy:max_y;


for j=1:image_size_y
    for k=1:image_size_x

        % get distance: pixel to radar
        distance=get_radar_distance()
        % calculate kernel
        h=get_kernel()
        %

        



    end
end

end

