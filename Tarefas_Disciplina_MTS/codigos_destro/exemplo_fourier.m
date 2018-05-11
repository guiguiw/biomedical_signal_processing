%Programa que permite ao usuario carregar um sinal EEG em formato .mat e
% analisar um canal 
%O programa calcula o módulo e fase do sinal após a transformada de Fourier e
%ainda a potencia do sinal, o sinal normalizado e a frequencia mediana do
%mesmo. Retorna ainda o vetor de frequencias do sinal. 
% 
% Variaveis de entrada
% X   vetor de dados de entrada [1xN]
% fa  frequencia de amostragem [Hz] escalar
%
% Supoe-se a base de tempo expressa de 0 a tf segundos
%
% FUNCOES NECESSARIAS PARA QUE O PROGRAMA SEJA EXECUTADO: integral.m,
% integralMod.m
%
% Variaveis de saida
% t     vetor de base de tempo, mesma dimensao de X
% f     vetor de base de frequencias, dimensao Nf
% XFF   vetor de fase da transformada de Fourier, dimensao Nf, radianos
% P     potencia espectral total do sinal, escalar
% XN    vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz]
% dm    frequencia mediana do sinal [Hz]
clear
clc
% close all
%load exemplo
% X = Do(1,1:10000);%
%N = length(X);
% tf = input('Digite o tempo final, expresso em segundos:\n');%
%fa = input('Digite a frequencia de amostragem:\n');
fa = 1000; fb = 100;
T = 1/fa; N = 10000;
t = 0:T:(N-1)*T; 
X = cos(2*pi*fb*t)+5*cos(2*pi*50*t) ;
%am_fin = tf*fa;
% xn = X(canal,1:am_fin);

%Vetor de Frequencias
f1_har = fa/N;
f = 0:f1_har:fa/2;
Nf = length(f);
XF = zeros(1, Nf); 
XM = zeros(1, Nf);
XFF = zeros(1, Nf);
XQ = zeros(1, Nf);
for k = 1 : Nf
    C = cos(2*pi*f(k).*t);
    S = sin(2*pi*f(k).*t);
    Cx = X .* C;
    Sx = X .* S;
    xrf = integral(Cx, fa);         
    xif = integral(Sx, fa);         
    XF(k) = xrf - 1i*xif;           
    XM(k) = sqrt(xrf^2 + xif^2);
    XFF(k) = atan2d(xif,xrf);
    XQ(k) = XM(k)^2;
end
% Normalizacao do espectro
P = integralMod(XQ, f);             
XN = XM ./ sqrt(P);                       
soma = 0;
for i = 1 : length(XN)
soma = soma + (XN(i) * f(i));
end
fm = soma/sum(XN);


