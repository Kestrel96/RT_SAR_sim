figure
doppler_axis=(-azimuth_samples/2:((azimuth_samples/2)-1))*PRF/azimuth_samples;
imagesc(raxis,doppler_axis,db(abs(radar.SAR_range_doppler)))
xlabel("Range [m]")
ylabel("Doppler freq [m]")
title("Range Doppler")
ax = gca;
%ax.YDir= 'normal';
