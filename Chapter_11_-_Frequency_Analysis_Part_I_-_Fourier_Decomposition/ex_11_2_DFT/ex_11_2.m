% EXERCISE 11.2
%     Write a MATLAB function to calculate
%     coefficients for a complex Fourier transform.
%     This is essentially the discrete
%     Fourier transform (DFT):
%         Fk = 1/N * SUM(fn*exp(-i*(2*pi*n/N)*k),n=0,n=N-1)
%     where k ranges from 0 to N-1, N is the
%     number of points, and f n is the value of the
%     function at point n.

%% Montando os vetores
t = linspace(0,1,100);
f = sin(2*pi*3*t) + 0.5 * sin(2*pi*6*t);
plot(t,f);

%% Preparacao
N = length(t);

%% Calculo da DFT
F = dft_coef(f);

%% Preparando eixos
fs = 1/(t(2) - t(1));
nyq = fs/2;
frequency = 0:(nyq/(N/2)):fs;

frequency = frequency(1:(N/2));
F = F(1:(N/2));
%% Mostrando
plot(frequency, abs(F))

