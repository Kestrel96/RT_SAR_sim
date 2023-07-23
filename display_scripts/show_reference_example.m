
figure
tiledlayout(2,1)
nexttile
imagesc(db(abs(radar.SAR_range_corrected)));
title("Range corrected data")
nexttile
plot(real(radar.SAR_range_corrected(:,126)))
hold on
plot(real(radar.SAR_azimuth_reference_LUT(251,2:end)));
title("Sample no. 126")
legend("Echo","Reference function")
%nexttile

% plot(real(radar.SAR_range_corrected(:,61)))
% hold on
% plot(real(radar.SAR_azimuth_reference_LUT(61,:)));
% title("Sample no. 61")