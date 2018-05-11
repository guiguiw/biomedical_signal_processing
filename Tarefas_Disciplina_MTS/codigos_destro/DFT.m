%% Fourier
% Programa para o calculo da transformada de Fourier de uma matriz
% O programa calcula o módulo e fase do sinal após a transformada de Fourier e
% ainda a potencia do sinal, o sinal normalizado e a frequencia mediana do
% mesmo. Retorna ainda o vetor de frequencias do sinal. 
%%   Data     ||      Programador               ||  Descrição de Mudança
% =========================================================================
% 10/02/2016  ||  Camila Davi Ramos             ||    Código original
% 15/03/2016  ||  Camila Davi Ramos             ||    Código adaptado para Matriz
% 27/09/2016  ||  Camila Davi Ramos             ||    Mudança nos parametros de entrada
%             ||                                ||    e saida da funcao
% 02/03/2018  ||  Gaspar Eugênio Oliveira Ramos ||    Alteração para função
% =========================================================================
%% Definições de Variáveis 
% Variáveis de entrada 
%
% xn -> MATRIZ de dados com 'L' linhas e 'N' colunas.
% t -> vetor de tempo correspondente ao sinal xn com 'N' colunas (em segundos).
% fs -> frequencia de amostragem com que o sinal xn foi aquisicionado (em Hz).
% =========================================================================
% Variáveis de saída
%
% XM -> MATRIZ de Modulo da transformada de Fourier (com L linhas e 
%       N/2 colunas).  
% XF -> MATRIZ de Parte real + imaginaria do sinal gerado pela transformada 
%       (com L linhas e N/2 colunas).
% f -> vetor de frequencias do sinal (normalmente com N/2 colunas). 
% =========================================================================
%% Funções necessárias para executar este codigo:
% integral.m
% integralMod.m
%% ========================================================================
function [XM, XF, f]=DFT(xn,t,fa)
%% Inicialização de variáveis auxiliares
[L, N] = size(xn);
f1_har = fa/N;
f = 0:f1_har:(fa/2);
Nf = length(f);
XF = zeros(L, Nf);
XM = zeros(L, Nf);
XFF = zeros(L, Nf);
%% Calculo da DFT
for r=1:L
    for k = 1 : Nf
        C = cos(2*pi*f(k).*t);
        S = sin(2*pi*f(k).*t);
        Cx = xn(r,:) .* C;
        Sx = xn(r,:) .* S;
        xrf = integralMod(Cx, t);
        xif = integralMod(Sx, t);
        XF(r,k) = xrf - 1i*xif;
        XM(r,k) = sqrt(xrf^2 + xif^2);
        XFF(r,k) = atan2(xif,xrf);
    end
end
%=====================================================================
%%
end

