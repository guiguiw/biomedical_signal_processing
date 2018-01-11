%% 11.3.4 Amplitude Spectrum

L = 1000;
X = zeros(1,L);
sampling_interval = 0.1;
t = (1:L) * sampling_interval;
for N = 1:10
    X = X + N * sin (N*pi*t);
end
plot(t, X);
Y = fft(X)/L;

NyLimit = (1 / sampling_interval)/ 2;

F = linspace(0,1,L/2)*NyLimit;
plot(F, abs(Y(1:L/2)));

%% 11.3.5 Power

plot(F, (Y(1:L/2).*conj(Y(1:L/2))));

%% 11.3.6 Phase Analysis and Coherence

L = 1000;
X = zeros(1,L);
sampling_interval = 0.1;
t = (1:L) * sampling_interval;
for N = 1:10
    X = X + N * sin (N*pi*t);
end
plot(t, X);
Y = fft(X)/L;
phi = atan(imag(Y)./real(Y));
F = linspace(0,1,L/2)*NyLimit;
plot(F, phi(1:L/2));