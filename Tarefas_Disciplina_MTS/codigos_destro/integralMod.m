%% Este programa objetiva calcular o resultado numerico da integral de um 
%vetor pelo metodo dos trapezios. 
% Faculdade de Engenharia El�trica- FEELT
%   Data               Programador          Descri��o de Mudan�a
%   ====               ===========          ====================
% __/__/20__      Aluno IC Destro           C�digo original
% 27/09/2016      Camila Davi Ramos         C�digo revisado 
% 27/09/2016      Camila Davi Ramos         Mudan�a nos parametros de entrada
%                                           e saida da funcao
%%%%%%%%% Defini��es de Vari�veis %%%%%%%%%
%%%%%%% Vari�veis de entrada %%%%%%%
%   - componente_vertical: Vetor de dados (ATENCAO DEVE SER VETOR) com N
%colunas (geralmente para sinal EEG � dado em microVolts). Sinal a ser
%integrado. 
%   - componente_horizontal: Vetor que contem informa��es dos tempos ou frequencias da
%componente_vertical (quando for componente no dom�nio do tempo � sempre
%dada em segundos e quando for componente no dom�nio da frquencia � sempre
%dada em Hz). Representa a vari�vel de integra��o. 
%NOTA: O comprimento da componente_vertical � id�ntido ao comprimento da
%componente_horizontal.
%%%%%%% Vari�veis de sa�da %%%%%%%
%   - resultado: Escalar resultante do metodo de integracao (esse escalar representa
%o c�lculo da �rea sob a curva formada pelas componentes vertical e horizontal e portanto
%geralmente � dado em microWatts para sinais EEG). 
%   - vetor: � o vetor resultante da integra��o do m�todo de trap�zio. O
%tamanho desse vetor � igual a N-1. 
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
