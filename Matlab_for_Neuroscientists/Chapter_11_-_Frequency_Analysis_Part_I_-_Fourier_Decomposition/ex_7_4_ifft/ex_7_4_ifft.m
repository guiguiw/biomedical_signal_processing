% EXERCISE 7.4
%     Generate a single sine wave. Use fft() to
%     generate the discrete Fourier transform. Use
%     ifft() to retrieve the original sine wave from
%     the DFT.

%% Clearing and clossing everything
clc;
clear;
close all;

%% Generating a single sin wave
Fs = 100;
t = 0:1/Fs:1;
y = sin(2*pi*3*t);

%% Generating the fourier transform
Y = fft(y);
f = 0:(length(t)/2)/(Fs/2):(Fs/2);
%% Retrieving the original sin wave
y2 = ifft(Y);

%% Ploting
subplot(3,1,1);
plot(t,y);
grid();
axis([0,1,-1,1]);
title('y = sin()');

subplot(3,1,2);
plot(f, abs(Y(1:floor(length(t)/2))));
grid();
title('Y = fft(y)');

subplot(3,1,3);
plot(t,y2);
grid();
axis([0,1,-1,1]);
title('y2 = ifft(Y)');
