
tiledlayout(2,1)
nexttile
imagesc(db(abs(radar.SAR_range_corrected)));
title("Range corrected data")
nexttile
plot(real(radar.SAR_range_corrected(:,116)))
hold on
plot(real(radar.SAR_azimuth_reference_LUT(116,2:end)));
title("Sample no. 116")
legend("Echo","Reference function")
%nexttile

% plot(real(radar.SAR_range_corrected(:,61)))
% hold on
% plot(real(radar.SAR_azimuth_reference_LUT(61,:)));
% title("Sample no. 61")