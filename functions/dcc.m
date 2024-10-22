function SAR_range_doppler = dcc(SAR_range_doppler)
%DCC Summary of this function goes here
%   Detailed explanation goes here


[rows,columns] = size(SAR_range_doppler);

for k=1:columns
    

    smoothed = smoothdata(abs(db(SAR_range_doppler(:,k))),"gaussian",1000);
    smoothed = smoothed/max(smoothed);
    [M,I] = max(smoothed);
    shift = rows/2-I;

    SAR_range_doppler(:,k) = circshift(SAR_range_doppler(:,k),shift);
end

end

