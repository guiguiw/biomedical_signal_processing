%% Fun��o para gerar a estima��o da integral num�rica de um vetor x
%   O m�todo de integra��o num�rica utilizado � o do trap�zio simples
%
% Vari�veis de entrada:
% x (vetor de dimens�o N): vetor de dados qualquer
% fa (escalar): frequ�ncia de amostragem em [Hz]
%
% Vari�veis internas:
% Ta (escalar): per�odo de amostragem em [s]
% N (escalar): quantidade de amostras do vetor de dados x
% t (matriz): vetor de tempo analogico [s],  comprimento N
%
% Vari�veis de sa�da:
% integralTotal (escalar): estima��o da integral num�rica do vetor x
% sinalintegral (vetor): sinal resultante da integracao, com mesma dimensao
%                        do vetor x [1xN]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ integralTotal ] = integral(x, time_vector)

%% Obten��o das vari�veis auxiliares para implementa��o do m�todo de
% integra��o num�rica (trap�zio simples)
Ta = time_vector(2) - time_vector(1);      % Per�odo de amostragem
N = length(x);% N�mero de amostras do vetor x
t = 0:Ta:Ta*(N-1);

%% Implementa��o do m�todo de integra��o
y = zeros(1,N); % Cria o vetor de sa�da
for k = 2 : N   % Itera��o do m�todo do trap�zio simples
y(k) = Ta*(((x(k-1) + x(k))/2)) + y(k-1);
end

integralTotal = y(N);
%sinalintegral = y;
end

