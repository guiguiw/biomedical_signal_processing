% EXERCISE 11.1
%     Write a MATLAB function to calculate
%     coefficients for a real Fourier transform.
%     Hint: The function will need to shift the
%     interval so that the interval encompasses
%     the entire time series. In other words, x = 0
%     and L = half the range of t.

% am = 1/L * integral(f(t) * cos((pi/L)*m*t), dt)
% bm = 1/L * integral(f(t) * sin((pi/L)*m*t), dt)

%% Montando os vetores
t = linspace(-pi,pi,1000);
f = sin(3*t) + 3;
plot(t,f);

%% Preparacao
L = pi;

%% Coeficientes da integral
a = zeros(10,1);
b = zeros(10,1);
a0 = (1/L) * trapz(t, f);
for m=1:50
    a(m) = (1/L) * trapz(t, f .* cos((pi/L)*m*t));
    b(m) = (1/L) * trapz(t, f .* sin((pi/L)*m*t));
end

%% Mostrando o coeficiente A
plot(a)

%% Mostrando o coeficiente B
plot(b)