%--------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering
%--------------------------------------------------------------------------
% Author(s): Italo Gustavo Sampaio Fernandes, Henrique Andrade Barbosa, Paulo
% Eduardo Alves, Giovanna Cavalcante Barndao lima e Ana Carolina Torres
%--------------------------------------------------------------------------
% Decription: 
% Variáveis de entrada:
%    - coma = matriz com todos os dados EEG da amostragem [20x2500]
%    - Fa = valor da frequencia de amostragem dada, 250Hz
%    - ti = tempo inicial, [ms]
%    - tf = tempo final, [ms]
%    - t = vetor com a base de tempo, vetor [1x2500]
%    - samplePeriod = período de amostragem, [ms]
%    - num_ch = quantidade de canais a serem plotados
% 
% Variáveis intermediárias:
%    - ni = coluna inicial da matriz coma, correspondente a ti
%    - nf = coluna final da matriz coma, correspondente a tf
% 
% Variáveis de saída:
%   - valores1 = subvetor associado a matriz coma com média nula,[20x((nf-ni)+1)]
%   - potencias = potencia de cada canal,vetor [1x20]
%   - Q = numero de linhas de coma encontrada com a função size
%   - N = numero de colunas de coma encontrada com a função size
% 
% Funções auxiliares:
%   - receberTempos = Recebe do usuario os tempos ti e tf
%   - GetValores1 = Retorna um vetor identico a X mas com media nula.     
%     Para cada canal, subtrai do seu valor o valor da media multiplicado
%     por um vetor de ones
%   - GetPotencia = Retorna a potencia media de cada canal em valores
%
%--------------------------------------------------------------------------
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

addpath('../datasets','../codigos_destro')
close all;

% -------------------------------------------------------------------------
% Select Dataset
% Carrega os aquivos salva em X e libera a memoria
load coma
x = coma; % Arquivo de 20 canais de EEG em [V],durante 10 segundos a 250Hz
Fa = 250; % Frequencia de Amostragem
% Definicao dos tempos de inicio e fim
[ti,tf] = receberTempos(); % Definicao do tempo final
clear coma;

[Q, N] = size(x);
samplePeriod = 1/Fa; % Periodo de Amostragem
t = samplePeriod*(0:(N-1)); % Vetor de tempo em [s]


% -------------------------------------------------------------------------
% Plotando Dados Lidos

num_ch = 3; % Selecione a Quantidade de canais que deseja plotar
figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), x(ii,(t >= ti & t < tf)));
    hold on;
    plot(t(t >= ti & t < tf), mean(x(ii,:))*ones(size(x(ii,(t >= ti & t < tf)))));
    legend('Sinal', ['Media = ' num2str(mean(x(ii,(t >= ti & t < tf))))] );
    grid on;
    title(['Coma - Canal ' num2str(ii)]) 
    ylabel('TensÃ£o [V]');
    xlabel('Tempo [s]');
end


% -------------------------------------------------------------------------
% Parte A - Calculo de Valores 1

% Chama a funÃ§Ã£o GetValores1
% Mandando como Argumento os valores de 
% X onde o tempo Ã© maior ou igual o tempo inicial
% e menor do que o tempo final
valores1 = GetValores1(x(:,t >= ti & t < tf)); 

% -------------------------------------------------------------------------
% Parte B - Calculo de Potencia

% Chama a funÃ§Ã£o GetPotencia com o mesmo argumento da parte A
potencias = GetPotencia(x(:,t >= ti & t < tf)); 

% -------------------------------------------------------------------------
% Plotando Dados Calculados

figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), valores1(ii,:));
    hold on;
    plot(t(t >= ti & t < tf), mean(valores1(ii,:))*ones(size(valores1(ii,:))));
    legend('Sinal', ['Media = ' num2str(mean(valores1(ii,:)))] );
    text(tf-3,-40,['Potencia: ' num2str(potencias(ii))])
    grid on;
    title(['Valores 1 - Canal ' num2str(ii)]) 
    ylabel('TensÃ£o [V]');
    xlabel('Tempo [s]');
end

