function range_corrected = rcmc2(range_doppler_data,delta_samples,samples)
%RCMC2 Summary of this function goes here
%   Detailed explanation goes here

[azimuth_steps,beat_samples]=size(range_doppler_data);
range_corrected=zeros(azimuth_steps,beat_samples);


buffer_zone=15;



for k=1:azimuth_steps-10
    for l=buffer_zone:beat_samples


%         tmp_signal=range_doppler_data(k,l-3:l+3);
%         xq=l-3:0.1:l+3;
%         x=l-3:l+3;
%         
%         tmp_interp=interp1(x,tmp_signal,xq);
% 
% 
%         
%         %new_l=round(l-delta);
% 
%         
%         new_l=l-delta_samples(k,l);
%         [~,ind]=min(abs(xq-new_l));

       
        %range_corrected(k,round(new_l))=tmp_interp(ind);
        sample_pre=range_doppler_data(k,l);
           r_delta=delta_samples(k,l);
        new_l=round(l-r_delta);
       range_corrected(k,new_l)=sample_pre;

    end

end


end

