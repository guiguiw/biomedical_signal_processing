%% Função para gerar a estimação da integral numérica de um vetor x
%   O método de integração numérica utilizado é o do trapézio simples
%
% Variáveis de entrada:
% x (vetor de dimensão N): vetor de dados qualquer
% fa (escalar): frequência de amostragem em [Hz]
%
% Variáveis internas:
% Ta (escalar): período de amostragem em [s]
% N (escalar): quantidade de amostras do vetor de dados x
% t (matriz): vetor de tempo analogico [s],  comprimento N
%
% Variáveis de saída:
% integralTotal (escalar): estimação da integral numérica do vetor x
% sinalintegral (vetor): sinal resultante da integracao, com mesma dimensao
%                        do vetor x [1xN]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ integralTotal,sinalintegral ] = integral(x)

%% Obtenção das variáveis auxiliares para implementação do método de
% integração numérica (trapézio simples)
Ta = x(1,2)-x(1,1);      % Período de amostragem
N = length(x);% Número de amostras do vetor x
t = 0:Ta:Ta*(N-1);

%% Implementação do método de integração
y = zeros(1,N); % Cria o vetor de saída
for k = 2 : N   % Iteração do método do trapézio simples
y(k) = Ta*(((x(k-1) + x(k))/2)) + y(k-1);
end

integralTotal = y(N);
sinalintegral = y;
end

