%% 12.2.2 Windows

L = 100;
w = hamming(L);
plot(1:L, w)

%% 12.3 EXERCISES

%%
%[amp, fs, nbits] = wavread('song1.wav');
load chirp
amp = y;
fs = Fs;
%%
spectrogram(amp, 256, 'yaxis')
%%
spectrogram(amp, 256, [ ], [ ], fs, 'yaxis')
%%
[S, F, T, P] = spectrogram(amp, 256, [ ], [ ], fs, 'yaxis');
mesh(P);