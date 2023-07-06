function azimuth_LUT = get_azimuth_reference(azimuth_axis,range_axis,fc,Alfa)
%GET_AZIMUTH_REFERENCE Summary of this function goes here
%   Detailed explanation goes here






















% samples_no=250;
% azimuth_zero_doppler=floor(length(azimuth_axis)/2);
% 
% positions=zeros(1,samples_no);
% half=azimuth_axis(azimuth_zero_doppler:-1:azimuth_zero_doppler-(samples_no/2-1));
% half=flip(half);
% positions(1:samples_no/2)=half;
% half=azimuth_axis(azimuth_zero_doppler:1:azimuth_zero_doppler+(samples_no/2-1));
% positions(samples_no/2+1:end)=half;
% d=zeros(length(range_axis),samples_no);
% 
% 
% 
% 
% for k=1:length(range_axis)
% %     for l=1:length(positions)
%         x_t=range_axis(k);
%         y_t=azimuth_axis(azimuth_zero_doppler);
%         x_r=0;
%         d(k,:)=sqrt((x_t)^2+(positions-y_t).^2);
% 
% end
% 
% 
% 
% azimuth_LUT=zeros(length(range_axis),samples_no);
% for k=1:length(range_axis)
%     c=3e8;
%     tau=2*d(k,:)/c;
%     tau2(1:samples_no)=range_axis(k);
% 
%     reference=exp(2*pi*1i*(fc*tau+Alfa*tau2));
%     %reference=reference(end:-1:1);
%     %reference=conj(reference);
%     azimuth_LUT(k,:)=reference;
% 
% 
% end


% figure
% for i = 1:length(azimuth_LUT)
% 
%     plot(real(azimuth_LUT(i,:)));
%     waitforbuttonpress
% 
% 
% end

