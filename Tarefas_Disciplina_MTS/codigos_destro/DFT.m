%% Fourier
% Programa para o calculo da transformada de Fourier de uma matriz
% O programa calcula o m�dulo e fase do sinal ap�s a transformada de Fourier e
% ainda a potencia do sinal, o sinal normalizado e a frequencia mediana do
% mesmo. Retorna ainda o vetor de frequencias do sinal. 
%%   Data     ||      Programador               ||  Descri��o de Mudan�a
% =========================================================================
% 10/02/2016  ||  Camila Davi Ramos             ||    C�digo original
% 15/03/2016  ||  Camila Davi Ramos             ||    C�digo adaptado para Matriz
% 27/09/2016  ||  Camila Davi Ramos             ||    Mudan�a nos parametros de entrada
%             ||                                ||    e saida da funcao
% 02/03/2018  ||  Gaspar Eug�nio Oliveira Ramos ||    Altera��o para fun��o
% =========================================================================
%% Defini��es de Vari�veis 
% Vari�veis de entrada 
%
% xn -> MATRIZ de dados com 'L' linhas e 'N' colunas.
% t -> vetor de tempo correspondente ao sinal xn com 'N' colunas (em segundos).
% fs -> frequencia de amostragem com que o sinal xn foi aquisicionado (em Hz).
% =========================================================================
% Vari�veis de sa�da
%
% XM -> MATRIZ de Modulo da transformada de Fourier (com L linhas e 
%       N/2 colunas).  
% XF -> MATRIZ de Parte real + imaginaria do sinal gerado pela transformada 
%       (com L linhas e N/2 colunas).
% f -> vetor de frequencias do sinal (normalmente com N/2 colunas). 
% =========================================================================
%% Fun��es necess�rias para executar este codigo:
% integral.m
% integralMod.m
%% ========================================================================
function [XM, XF, f]=DFT(xn,t,fa)
%% Inicializa��o de vari�veis auxiliares
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

