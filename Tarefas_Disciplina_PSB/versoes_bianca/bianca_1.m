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

% Carregamento de dados 
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
t = T * [0:(N-1)]

% Declaração da matriz de sinal 
sinal = ones(1, N);

% Declaração de uma matriz unitária
% Essa matriz unitária é importante pois sempre será multiplicada pela
% matriz de média
mu = ones (1, N);

% Matriz que conterá os valores resultantes da média de cada linha 
media = ones(1,L);

contador = 1; 

while(contador <= L)
    
    %vm é uma matriz que receberá o valor médio de cada linha da matriz
    %Valores1. Para cada valor de contador, todas as colunas da matriz
    %Valores1 será percorrida, e em vm será armazenado valor médio disto.
    vm = mean(Valores1(contador, ); 
    
    % O vetor linha mu, isto é, aquele formado por 1 linha e o número de
    % colunas igual ao número de colunas da matriz Valores1, será
    % multiplicado por cada vm, que representa a média do sinal.
    mu = mu*vm;
    
    % A matriz media, que na verdade configura-se como um vetor coluna,
    % formado por uma linha e 20 colunas (referentes ao número de linhas da
    % matriz Valores1) irá receber a média de cada linha da matriz
    % Valores1.

Valores1 (contador,:) = Valores1(contador,:) - mu(contador,:);
    media(contador,  = mean(Valores1(contador, );
    
    % O contador deve ser incrementado a cada loop.
    contador = contador + 1;

    % Gráfico Valores1 x tempo -> mostra os valores obtidos, ou seja, as
    % amostras colhidas por cada eletrodo para cada valor de tempo.
    plot(t,Valores1);
    
    
    % Função Potência 
    
    cont = 1; 
    cont2 = 1;
    potencia = zeros(1, L);
    int numero;
    
    while(cont <= L)
        
        while(cont2 <= N)
            
            % O numero vai receber o valor do elemento da matriz Valores1
            % localizado na linha referente ao valor de cont(cont vai
            % percorrer todas as linha da matriz Valores1) e da coluna
            % cont2( cont2 vai percorrer todas as colunas da matriz
            % Valores1). Ou seja, para o primeiro loop, o numero irá
            % receber o valor da matriz que está na linha 1 e coluna 1, ou
            % seja, a(11).
            numero = Valores1(cont, cont2);
            
            % A matriz potencia, que na verdade é um vetor coluna (possui
            % uma linha e o número de colunas igual ao número de colunas da
            % matriz Valores1) irá receber o número(valor de cada posição
            % da matriz Valores1) elevado ao quadrado, mais o próprio valor
            % da matriz potência. 
            % A matriz potencia conterá então um total de 20 colunas, em
            % que cada coluna será preenchida pela potência (calculado
            % através da fórmula mostrada acima) dos elementos referentes a
            % linha (igual ao valor do contador) da matriz Valores1.
            potencia(1,cont) = (numero)^2 + potencia(1,cont);
            
            % O contador 2 será incrementado, assim, ele percorrerá todas
            % as colunas da matriz Valores1, de modo que o número receba
            % sequencialmente a(11), a(12), a(13) até o 2500º elemento da
            % linha referente ao valor de cont da matriz.
            cont2 = cont2 + 1; 
            
        end
               
              % Para cada somatório (somatório de cada elemento de cada
              % linha da matriz Valores1 elevado ao quadrado), o valor
              % final deve ser dividido pelo número de colunas total da
              % matriz Valores1, que se refere ao número de amostras
              % totais.
              potencia(1,cont)= (potencia(1,cont))/N; 
              
              % O contador deve ser incrementado a cada loop, de modo a
              % percorrer cada linha da matriz Valores1. Assim, a variavel
              % numero vai ser sequencialmente a(1..) a(2..) a(3..)
              
              cont=cont+1;
    end
