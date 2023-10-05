imagesc(real(radar.SAR_raw_data))
xlabel("Samples")
ylabel("Pulse (Azimuth)")
title("SAR Raw Data")
ax = gca;
ax.YDir= 'normal';