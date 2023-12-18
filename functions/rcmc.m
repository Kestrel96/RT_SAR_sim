function SAR_RD_range_corrected = rcmc(SAR_range_doppler,delta_samples)
%RCMC Summary of this function goes here
%   Detailed explanation goes here


[rows,cols]=size(SAR_range_doppler);
SAR_RD_range_corrected=zeros(rows,cols);



 for i=1:rows
 
     mean_shift=round(mean(delta_samples(i,:)));
 
     SAR_RD_range_corrected(i,:)=circshift(SAR_range_doppler(i,:),-mean_shift);
     SAR_RD_range_corrected(i,end-mean_shift:end)=0;

 end


% for i=1:rows
% 
% 
%      for k=1:cols
% 
%          % new_index=round(k-delta_samples(i,k));
%          new_index=k-round(delta_samples(i,k));
% 
%          if(new_index <=0)
%             continue
%          end
%          SAR_RD_range_corrected(i,new_index)=SAR_range_doppler(i,k);
% 
% 
% 
% 
%      end
% end


end

