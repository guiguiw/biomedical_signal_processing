%% Este programa objetiva calcular o resultado numerico da integral de um 
%vetor pelo metodo dos trapezios. 
% Faculdade de Engenharia Elétrica- FEELT
%   Data               Programador          Descrição de Mudança
%   ====               ===========          ====================
% __/__/20__      Aluno IC Destro           Código original
% 27/09/2016      Camila Davi Ramos         Código revisado 
% 27/09/2016      Camila Davi Ramos         Mudança nos parametros de entrada
%                                           e saida da funcao
%%%%%%%%% Definições de Variáveis %%%%%%%%%
%%%%%%% Variáveis de entrada %%%%%%%
%   - componente_vertical: Vetor de dados (ATENCAO DEVE SER VETOR) com N
%colunas (geralmente para sinal EEG é dado em microVolts). Sinal a ser
%integrado. 
%   - componente_horizontal: Vetor que contem informações dos tempos ou frequencias da
%componente_vertical (quando for componente no domínio do tempo é sempre
%dada em segundos e quando for componente no domínio da frquencia é sempre
%dada em Hz). Representa a variável de integração. 
%NOTA: O comprimento da componente_vertical é idêntido ao comprimento da
%componente_horizontal.
%%%%%%% Variáveis de saída %%%%%%%
%   - resultado: Escalar resultante do metodo de integracao (esse escalar representa
%o cálculo da área sob a curva formada pelas componentes vertical e horizontal e portanto
%geralmente é dado em microWatts para sinais EEG). 
%   - vetor: É o vetor resultante da integração do método de trapézio. O
%tamanho desse vetor é igual a N-1. 
%=====================================================================
%%
function [ resultado,vetor] = integralMod( componente_vertical, componente_horizontal )
N = length(componente_horizontal);
y = zeros(1,N); 
for k = 2 : N   
y(k) = (componente_horizontal(k) - componente_horizontal(k-1))*(((componente_vertical(k-1) + componente_vertical(k))/2)) + y(k-1);
end
resultado = y(N);
vetor = y;
end
%=====================================================================
%%
