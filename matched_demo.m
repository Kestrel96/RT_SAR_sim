% Parameters
fs = 1000;            % Sampling frequency (Hz)
total_duration = 2.5;   % Total time duration (seconds)
t = 0:1/fs:total_duration;  % Time vector (5 seconds duration)
f0 = 10;              % Start frequency of chirp (Hz)
f1 = 100;             % End frequency of chirp (Hz)
chirp_duration = 1;   % Duration of the chirp signal (seconds)
close all

chirp_t = 0:1/fs:chirp_duration;

% Generate chirp signal
signal = chirp(0:1/fs:chirp_duration, f0, chirp_duration, f1);

% Place chirp signal at 2 seconds in the time vector
signal_position = 1;  % Position of the chirp in the time vector (seconds)
signal_start = signal_position * fs + 1;  % Starting index of the chirp
signal_end = signal_start + length(signal) - 1;

% Initialize full signal with zeros
full_signal = zeros(1, length(t));

% Insert chirp signal into the full signal
full_signal(signal_start:signal_end) = signal;

% Add noise to the full signal
noise = 0.7 * randn(size(t));  % Gaussian noise
noisy_signal = full_signal + noise;

% Matched filter (using the time-reversed chirp signal as the filter)
matched_filter_output = conv(noisy_signal, fliplr(signal), 'same');

% Plotting the results
matched_filter_figure=figure('Name','MatchedDemo','NumberTitle','off','Position', [0 0 1600 900]);
subplot(4, 1, 1);
plot(chirp_t,signal);
title('Transmitted Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2)
plot(chirp_t,fliplr(signal));
title('Filter Kernel');
xlabel('Time (s)');
ylabel('Amplitude');


subplot(4, 1, 3);
plot(t, noisy_signal);
title('Noisy Signal (Echo)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 1, 4);
plot(t, matched_filter_output/max(matched_filter_output));
ylim([-0.3,1.1])
title('Matched Filter Output (Normalized)');
xlabel('Time (s)');
ylabel('Amplitude');

% Adjust layout
%sgtitle('Matched Filtering Demonstration with Chirp Signal at 2 Seconds');
saveas(matched_filter_figure,"./graphics/matched_demo.png");
