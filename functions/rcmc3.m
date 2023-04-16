function SAR_RD_range_corrected = rcmc3(SAR_range_doppler,delta_samples)
%RCMC3 Summary of this function goes here
%   Detailed explanation goes here


[rows,cols]=size(SAR_range_doppler);
SAR_RD_range_corrected=zeros(rows,cols);



for i=1:rows
    
    for k=1:cols

        new_index=round(k-delta_samples(i,k));
        if(new_index <=0)
            continue
        end
        SAR_RD_range_corrected(i,new_index)=SAR_range_doppler(i,k);

        


    end
end


end

