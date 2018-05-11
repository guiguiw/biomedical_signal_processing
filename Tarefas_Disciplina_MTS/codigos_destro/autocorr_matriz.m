%% Este programa objetiva calcular a AUTOCORRELÇAO NÂO NORMALIZADA de uma matriz.
% Faculdade de Engenharia Elétrica- FEELT
%   Data               Programador                  Descrição de Mudança
%   ====               ===========                  ====================
% __/__/20__      Tatiane                           Código original
% 27/09/2016      Camila Davi Ramos                 Código adaptado para Matriz
% 27/09/2016      Camila Davi Ramos                 Mudança nos parametros de entrada
%                                                   e saida da funcao
% 10/11/2017      Gaspar Eugênio Oliveira Ramos     Adaptação para PDS não
%                                                   normalizada
%%%%%%%%% Definições de Variáveis %%%%%%%%%
%%%%%%% Variáveis de entrada %%%%%%%
%   - x = matriz de dados ('L' linhas e 'N' colunas) que representa o sinal para 
%o calculo da autocorrelação.  
%   - taumax = escalar que representa o comprimeto do vetor Rx (quantidade 
%de amostras). Obs: taumax deve ser menor que o comprimento de x 
%(Em 2015-2017 para sinais EEG recomenda-se usar igual a 100). 
%   - Ta = periodo de amostragem (em segundos)do sinal x.
%%%%%%% Variáveis de saída %%%%%%%
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

