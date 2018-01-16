% Disciplina: Processamento de Sinais Biomédicos
% Professor: João Batista Destro Filho
% Grupo: Ana Carolina Torres, Giovanna Cavalcanti, Henrique Andrade, Ítalo
% Fernandes, Paulo Eduardo Alves
% Data: 27 de setembro de 2017
% Código referente à Tarefa1
% ------------------------------------------------------------------------------
% TAREFA 1
% Considere o arquivo de dados coma.mat, em que fa = 250 Hz.
% (1 ) Elaborar um programa com nome “Tarefa1.m” que aceite como entrada os dados contidos
%	no arquivo coma.mat, a especificação de um tempo inicial ti (medido em [ms]) e a
%	especificação de um tempo final tf (medido em [ms]); e que gere como saída as seguintes
%	matrizes.
% 		(a ) “Valores1”: análoga à matriz “coma”, porém com todos os canais de sinais EEG de média
% 		nula, e supondo uma submatriz associada aos dados de EEG considerados a partir do instante
% 		de tempo ti, incluindo até o tempo tf.
% 		(b) “Potencia”: vetor que armazena, para cada linha da matriz “Valores1”, a potência média de
% 		cada linha da matriz “Valores1”
%		, onde N é o
%	Fórmula para o cálculo da potência de um vetor qualquer
%	comprimento total do vetor e onde se supõe a média dos elementos como sendo nula:
%	Observação: Os valores de ti e de tf devem ser especificados no inicio do programa.
% ------------------------------------------------------------------------------
addpath
% Carregamento dos dados
load coma;
Valores1 = coma;
clear coma;

% Outra forma de carregar os dados:
% Valores1 = importdata('coma.mat'); 

% Tamanho das colunas e das linhas da matriz carregada
% Q = linhas 
% N = colunas
[Q,N] = size(Valores1);

% Frequência da amostra (250Hz)
fa = 250;

% Período 
T = 1/fa;

% Base de tempo
t = T*(0:(N-1)); % t = [0 T 2T ... (N-1)T]

% Tempo inicial
ti = T*0;  

% Tempo final
tf = T*(N-1); 

% Contador
contador=1; 

% Matriz unitária
mu = ones(1,N);

% Matriz que conterá o sinal
sinal =ones(1,N); 

% Matriz para visualização da média de cada sinal(linha)
Media= ones(1,Q);
 
% Função para que a mádia seja Zero 
while(contador <=Q) % contador vai varrer de 1 ate 20(quantidade de sinais)

    vm = mean(Valores1(contador,:)); % cálculo da média da linha selecionada pelo contador
    mu = ones(1,N); % sempre colocar a matriz unitaria para que possa multiplicar o valor médio
    mu = mu*vm; % o valor médio do sinal vai multiplicar na matriz unitária
    
    Valores1(contador,:)= (Valores1(contador,:)) - (mu(1,:)); % deslocamento vertical do gráfico 
       
           Media(1,contador)= mean(Valores1(contador,:)); % facilitar a visualização da média dos sinais
       
    contador=contador+1;
end

% Plotar todos os sinais
plot(t,Valores1); 

% Função Potência

contador=1; % contador de linha
subcontador=1; % contador de coluna
Potencia= zeros(1,Q); %  vetor de zeros 
double numero;

while(contador<=Q) % Primeiro ele seleciona uma linha
    
    while(subcontador<=N) % Depois ele seleciona cada coluna da linha selecionada anteriormente
        numero = Valores1(contador,subcontador); % o número será cada valor da linha selecionada
        Potencia(contador)= (numero)^2 + Potencia(contador); % o quadrado do número somado com o valor anteriormente encontrado
        subcontador= subcontador+1;
    end
    
    Potencia(contador)= (Potencia(contador))/N; % divide toda a somatória pelo número de valores(colunas)
    subcontador=1;
    contador=contador+1;
end



