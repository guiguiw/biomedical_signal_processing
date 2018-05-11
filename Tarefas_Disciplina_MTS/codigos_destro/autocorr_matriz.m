%% Este programa objetiva calcular a AUTOCORREL�AO N�O NORMALIZADA de uma matriz.
% Faculdade de Engenharia El�trica- FEELT
%   Data               Programador                  Descri��o de Mudan�a
%   ====               ===========                  ====================
% __/__/20__      Tatiane                           C�digo original
% 27/09/2016      Camila Davi Ramos                 C�digo adaptado para Matriz
% 27/09/2016      Camila Davi Ramos                 Mudan�a nos parametros de entrada
%                                                   e saida da funcao
% 10/11/2017      Gaspar Eug�nio Oliveira Ramos     Adapta��o para PDS n�o
%                                                   normalizada
%%%%%%%%% Defini��es de Vari�veis %%%%%%%%%
%%%%%%% Vari�veis de entrada %%%%%%%
%   - x = matriz de dados ('L' linhas e 'N' colunas) que representa o sinal para 
%o calculo da autocorrela��o.  
%   - taumax = escalar que representa o comprimeto do vetor Rx (quantidade 
%de amostras). Obs: taumax deve ser menor que o comprimento de x 
%(Em 2015-2017 para sinais EEG recomenda-se usar igual a 100). 
%   - Ta = periodo de amostragem (em segundos)do sinal x.
%%%%%%% Vari�veis de sa�da %%%%%%%
%   - Rx = matriz que representa a autocorrelacaoo de x (com 'L' linhas e 'taumax' colunas).
%   - Tx = vetor que representa o tempo da autocorrelacao baseado em Ta e no valor do
% taumax (em segundos)(com '1' linha e  'taumax' colunas).
%=====================================================================
%%
function [Rx,Tx] = autocorr_matriz(x,fa)
Ta = 1/fa;
taumax = fix((400*fa)/240);
[L, N] = size(x); 
Rx = zeros(L,taumax);

for j=1:L
    Rx(j,1) = (x(j,:) * x(j,:)')/N;
    for tau = 1:taumax - 1
        soma = 0;
        for i = 1:N-tau
            soma = soma + x(j,i)*x(j,i+tau);
        end
        Rx(j,tau+1) = soma/((N*Ta)-(tau*Ta));
    end
%              Rx(j,:) = Rx(j,:)/max(Rx(j,:));
end
Tx = 0:Ta:(taumax-1)*Ta;
end

%=====================================================================
%%

