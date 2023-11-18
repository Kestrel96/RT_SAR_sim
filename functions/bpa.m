function SAR_img = bpa(SAR_range_compressed,azimuth_axis,image_size_x,image_size_y,min_x,min_y,max_x,max_y,dx,dy,fc)
%UNTITLED Summary of this function goes here
%   x - range (fast time)
%   y - azimuth (slow time)

SAR_img=zeros(image_size_x,image_size_y);

pixels=zeros(image_size_y,image_size_x);
pixels_x_centers=min_x+dx/2:dx:max_x+dx/2;
pixels_y_centers=min_y+d7/2:dy:max_y+dy/2;


for j=1:image_size_y
    for k=1:image_size_x

        % get distance: pixel to radar
        distance=get_distance();
        % calculate kernel
        h=pixel_kernel(distance,fc);
        H=fft(H);
        %

        

    end
end

end

