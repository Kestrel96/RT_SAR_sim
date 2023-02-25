%% Display Data

faxis=0:1/fs:samples*1/fs-1/fs;
figure
tiledlayout(1,3)
nexttile
imagesc(real(SAR_raw));
xlabel("Sample")
ylabel("Pulse")
nexttile
%imagesc(range_cells,azimuth_cells,db((SAR_range_compressed)));
imagesc(db(abs(SAR_range_compressed)));
title("Range compressed data")
nexttile
%imagesc(range_cells,azimuth_cells,db((SAR_range_compressed)));
imagesc(db(abs(SAR_range_corrected)));
title("Range corrected data")




% plot(real(SAR_raw(1,1:100))

% Range FFT, racalualte beat frequency/range

% azimuth - get overalapping parts of RX/TX
% get cycle through columns - get chrirp like azimuth signal
% fftilt?