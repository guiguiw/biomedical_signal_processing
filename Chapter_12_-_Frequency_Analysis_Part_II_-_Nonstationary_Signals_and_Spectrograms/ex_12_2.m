% EXERCISE 12.2
%     Examine the result of the spectrogram
%     with varying window sizes for the follow-
%     ing time series:
%     .. t = 0:0.05:1;
%     .. X = [sin(5*t) sin(50*t) sin(100*t)];
%     Try values ranging from 16 to 1024 for
%     the Hamming window width. How does
%     the representation change with different
%     Hamming window widths? Why might this
%     occur?
%%
t = 0:0.0025:1;
X = [sin(5*t) sin(50*t) sin(100*t)];
fs = 1/(t(2)-t(1));
%%
spectrogram(X, 16, [ ], [ ], fs, 'yaxis')
%%
spectrogram(X, 32, [ ], [ ], fs, 'yaxis')
%%
spectrogram(X, 64, [ ], [ ], fs, 'yaxis')
%% 
spectrogram(X, 128, [ ], [ ], fs, 'yaxis')
%%
spectrogram(X, 512, [ ], [ ], fs, 'yaxis')
%%
spectrogram(X, 1024, [ ], [ ], fs, 'yaxis')