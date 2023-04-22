
tiledlayout(3,1)
nexttile
imagesc(db(abs(radar.SAR_range_corrected)));
nexttile
plot(real(radar.SAR_range_corrected(:,116)))
hold on
plot(real(LUT(116,:)));
nexttile
plot(real(radar.SAR_range_corrected(:,61)))
hold on
plot(real(LUT(61,:)));