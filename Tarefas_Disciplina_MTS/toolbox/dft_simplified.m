function [freqs, pows] = dft_simplified(raw_data,samp_freq)
%FFT_SIMPLIFIED Summary of this function goes here
%   Detailed explanation goes here

pows = 2 * abs(fft(raw_data)) / length(raw_data); % Compute Magnitude DFT of x
pows = pows(1:floor(length(raw_data)/2));
freqs = (0:floor(length(raw_data)/2)-1)*samp_freq/(length(raw_data));        % Frequency vector

% t = linspace(0,length(raw_data)/samp_freq,length(raw_data));
% [pows, ~, freqs] = DFT(raw_data, t, samp_freq);
end

