%% 13.2.4 Scalograms

%%
Fs = 5000;
total_time = 5;
t = (1/Fs):(1/Fs):(total_time/3);
f = [100 500 1000];
x = [cos(f(1)*2*pi*t) cos(f(2)*2*pi*t) cos(f(3)*2*pi*t)];
t = (1/Fs):(1/Fs):total_time;

%spectrogram(x, 512, [], [], Fs, 'yaxis')
%%
%add short transients
trans_time = 0:(1/Fs):0.05;
trans_f = 1000;
for secs = 0.5:0.5:4
    trans = cos(trans_f*2*pi*trans_time);
    x((secs*Fs):(secs*Fs + length(trans) - 1)) = trans;
end

%spectrogram(x, 512, [], [], Fs, 'yaxis')
%%
scales = 1:200;
coefs = my_cwt(t, x, @my_morlet, 10, scales, [10]);
plot_cwt(t, coefs, scales);

%% 13.2.6 Wavelet Toolbox
coefs = cwt(x, 1:200, 'morl', 'plot');
%[cA. cD] = dwt(X, 'morl');
%X = idwt(cA, cD, 'morl');

%%
% here size(s) = 128
[C, L] = wavedec(x, 7, 'db4');
time = t(length(t));
for scale = 2:7
    subplot(7,1,scale)
    c_sub = (2^(scale-1)):(2^scale);
    t_sub = linspace(1, time,length(c_sub));
    plot(t_sub, C(c_sub))
end

%%
wavedemo

%%
% After all of this i still having no ideia what the fuck is this wavelet
