% TAREFA 1
% Considere o arquivo de dados coma.mat, em que fa = 250 Hz.
% (1 ) Elaborar um programa com nome “Tarefa1.m” que aceite como entrada os dados contidos
% no arquivo coma.mat, a especificação de um tempo inicial ti (medido em [ms]) e a
% especificação de um tempo final tf (medido em [ms]); e que gere como saída as seguintes
% matrizes.
%   (a ) “Valores1”: análoga à matriz “coma”, porém com todos os canais de sinais EEG de média
%   nula, e supondo uma submatriz associada aos dados de EEG considerados a partir do instante
%   de tempo ti, incluindo até o tempo tf.
%   (b) “Potencia”: vetor que armazena, para cada linha da matriz “Valores1”, a potência média de
%   cada linha da matriz “Valores1”
%  , onde N é o
% Fórmula para o cálculo da potência de um vetor qualquer
% comprimento total do vetor e onde se supõe a média dos elementos como sendo nula:
% Observação: Os valores de ti e de tf devem ser especificados no inicio do programa.
% ------------------------------------------------------------------------------

%% Dica: Limpar a tela, fechar todos os graficos e limpar as variaveis
clc; % Limpa os comandos
close all; % Fecha todos os graficos abertos
clear all; % Limpa todas a variveis

%% Carregamento de dados 
load coma; 
Valores1 = coma; 
clear coma;

% Tamanho da matriz (número de linhas e colunas) da matriz carregada
% L = número de linhas
% N = número de colunas 
[L, N] = size(Valores1);

% Frequência de amostragem (250 Hz)
fa = 250; 

% Período de amostragem -> é o inverso da frequência de amostragem
T = 1/fa; 

% Faixa de tempo 
% O tempo vai variar da seguinte forma: [0 T 2T 3T] 
t = T * (0:(N-1));

%% Calculo da media nula
% Declaração de uma matriz unitária
% Essa matriz unitária é importante pois sempre será multiplicada pela
% matriz de média
% Por exemplo mu = [1, 1, 1, ...]
mu = ones (1, N);

% Matriz que conterá os valores resultantes da média de cada linha
medias = ones (1, N);

%vm é uma matriz que receberá o valor médio de cada linha da matriz
%Valores1. Para cada valor de contador, todas as colunas da matriz
%Valores1 será percorrida, e em vm será armazenado valor médio disto.
% Por exemplo: Se Valores1 = [ 1, 2, 3; 4, 5, 6]
% Então: mean(Valores1,2) = [2; 5] por (1+2+3)/3 = 2 e etc..
% se não colocar o 2: mean(Valores1) = [2.5, 3.5, 4.5] pois (1+4)/2 = 2.5
vm = mean(Valores1,2);

for Contador=1:L % Neste caso um for é mais apropriado
    % O vetor linha mu, isto é, aquele formado por 1 linha e o número de
    % colunas igual ao número de colunas da matriz Valores1, será
    % multiplicado por cada vm, que representa a média do sinal.
    % Por exemplo: se mu = [1, 1, 1] e vm = [2; 5]
    % media = [2, 2, 2] quando contador valer 1
    % media = [5, 5, 5] quando contador valer 2 e assim por diante
    medias = mu * vm(Contador);
    
    % A matriz media, que na verdade configura-se como um vetor linha,
    % formado por uma linha e 20 colunas (referentes ao número de linhas da
    % matriz Valores1) irá receber a média de cada linha da matriz
    % Valores1.
    % Por exemplo: Se Valores1 = [1, 2, 3; 4, 5, 6] e media = [2, 2, 2]
    % pois contador vale 1, então Valores1 = [0, 1, 2; 4, 5, 6]
    % Quando contador valer 2. ele executara a proxima linha
    % A notação ':' é usada para representar todos os valores daquele canal
    % Por exemplo: x = [1, 2, 3; 4, 5, 6]
    %              x(1,:) = [1, 2 ,3] linha1 e todas as colunas
    %              x(:,1) = [1; 4] todas as linhas e coluna 1
    Valores1(Contador,:) = Valores1(Contador,:) - medias;
    
    % Gráfico Valores1 x tempo -> mostra os valores obtidos, ou seja, as
    % amostras colhidas por cada eletrodo para cada valor de tempo.
    % Esse plot pode deixar tudo mais lento, se não for necessario deixar
    % comentado deixa mais rapido
    % plot(t,Valores1(Contador));
    % Dica use o title, xlabel, ylabel e grid, para melhorar seu grafico
end

%% Função Potência
% Potencia é igual 1/N multiplicado pelo somatorio de:
% a ao quadrado (no caso valores1.^2). O ponto significa que é 
% para realizar a operação escalar e não a matricial. Ou seja executar
% valor a valor e não como se todos os valores fossem uma matriz como em GA
% Exemplos:
% Sem o ponto: [1, 2; 3, 4]^2 = [1, 2; 3, 4]*[1, 2; 3, 4] = [7, 10; 15, 22]
% Com o ponto: [1, 2; 3, 4].^2 = [1², 2²; 3², 4²] = [1, 4; 9, 16]
% O segundo 2 signifca que é pra realizar na linha pora linha e não coluna 
% por coluna que é o padrão. O numero 2 pelo help do matlab é a dimensão 
% que você quer que execute a função.
% Exemplo: Sem o 2: sum([1 2 3; 4 5 6]) = [5 7 9]
%          Com o 2: sum([1 2 3; 4 5 6], 2) = [ 6
%                                              15]     
potencia = (1/N) * sum(Valores1.^2, 2);

% Dicas, para ver o valor da media antes de subtrair digite:
% vm'
% E depois de subtrair digite:
% mean(Valores1,2)'
%Você vai notar que as novas medias são numeros muito pequenos proximos a 0
% E para ver a potencia:
% potencia'