% ------------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering Lab
% ------------------------------------------------------------------------------
% Author: Italo Gustavo Sampaio Fernandes
% Contact: italogsfernandes@gmail.com
% Git: www.github.com/italogfernandes
% ------------------------------------------------------------------------------
% Decription:
% ------------------------------------------------------------------------------
% Info Variavéis:
% 'Variável:' 'Informacao:';
% 'canais_ordem' 'Matriz de nomes dos canais, tem correspondência direta linha a linha com "xn"';
% 'T' 'Período de amostragem (baseado na taxa de amostragem) em segundos';
% 'fa' 'Taxa de amostragem da coleta (em Hz)';
% 'xn' 'Matriz de valores para os canais -> Correspondência direta linha a linha com "canais_ordem". Valores em uV do EEG naquela amostra';
% 'N' 'Quantidade de amostras por canal';'n_canais' 'Quantidade de canais na matriz "xn"';
% 'tempo_total' 'tempo total do exame (em segudos)';
% 't' 'vetor tempo para plotagem (em segundos)'
% 
% Canais Ordem:
% 1     2       3       4       5       6       7       8       9       10
% 'F5—' 'F61'   'FFa'   'Fp—'   'F22'   'Fp1'   'F11'   'T7O'   'C31'   'Cz2'
% 11    12      13      14      15      16      17      18      19      20
% 'C42' 'T81'   'T3—'   'C31'   'Pz2'   'C42'   'T41'   'O31'   'Oz2'   'O42'
% 21
% 'Cz2'
%
% Em aula foram utilizados os eletrodos 14 e 16. (C31 e C42)

%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro')

%% Clearing the enviroment
clear; close all; clc;

%% Loading the data
load('EEG_Metrologia.mat');

%% Choosing 2 Electrodes
C3 = xn(9, :);
C4 = xn(11, :);

%% Optional: Plotting the data
subplot(2,1,1);
plot(t, C3);
title('Loaded Data - C3');
xlabel('Time [s]');
ylabel('Tensão [uV]');
grid on;

subplot(2,1,2);
plot(t, C4);
title('Loaded Data - C4');
xlabel('Time [s]');
ylabel('Tensão [uV]');
grid on;

%% Splitting the data
% Vetor do inicio das epocas
tE = [2, 6, 13, 23, 34, 51, 80, 108, 118, 165];
qntE = length(tE);
dE = 2;
C3E = zeros(qntE, dE * fa + 1);
C4E = zeros(qntE, dE * fa + 1);
for ii=1:qntE
    C3E(ii,:) = C3(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
    C4E(ii,:) = C4(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
end
t_cada_epoca = 0:T:dE;
%% Auto Correlation Matriz

[C3Rx, C3Tx] = autocorr_matriz(C3, fa);
[C4Rx, C4Tx] = autocorr_matriz(C4, fa);
[C3ERx, C3ETx] = autocorr_matriz(C3E, fa);
[C4ERx, C4ETx] = autocorr_matriz(C4E, fa);

%% Oprtional: Plotting the 'epocas'
figure('NumberTitle', 'off', 'Name', 'Epocas de C3');
for ii=1:qntE
    subplot(5,2,ii);
    plot(t_cada_epoca, C3E(ii, :));
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
end
figure('NumberTitle', 'off', 'Name', 'Epocas de C4');
for ii=1:qntE
    subplot(5,2,ii);
    plot(t_cada_epoca, C4E(ii, :));
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
end

%% Calculating PSD (Power Spectrum Density)
[C3XM, ~, C3f] = DFT(C3Rx, C3Tx, 1/(C3Tx(2) - C3Tx(1)));
[C4XM, ~, C4f] = DFT(C4Rx, C4Tx, 1/(C4Tx(2) - C4Tx(1)));
% Corrigindo a tensão com 10-9
% TODO: Explicar o porque desse fator de correção
C3XM = C3XM .* 10E-9;
C4XM = C4XM .* 10E-9;

%% Calculating PSD (Power Spectrum Density) "Epocas"
[C3EXM, ~, C3Ef] = DFT(C3ERx, C3ETx, 1/(C3ETx(2) - C3ETx(1)));
[C4EXM, ~, C4Ef] = DFT(C4ERx, C4ETx, 1/(C4ETx(2) - C4ETx(1)));
% Corrigindo a tensão com 10-9
% TODO: Explicar o porque desse fator de correção
C3EXM = C3EXM .* 10E-9;
C4EXM = C4EXM .* 10E-9;

%% Optional: Plotting the PSD 
figure();
plot(C3f, C3XM);
title('PSD - Power Spectrum Density');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 100]);
hold on;
plot(C4f, C4XM);
grid on;
legend('C3','C4');

%% Optional: Plotting the PSD (Epocas)
% TODO: falar por que ele normaliza todas as epocas
figure();
plot(C3Ef, C3EXM);
title('PSD - Power Spectrum Density of All');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 100]);
grid on;

%% Oprtional: Plotting the 'epocas'
figure('NumberTitle', 'off', 'Name', 'PSD de C3');
for ii=1:qntE
    subplot(5,2,ii);
    plot(C3Ef, C3EXM(ii, :));
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 100]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(C3f, C3XM);
end
figure('NumberTitle', 'off', 'Name', 'PSD de C4');
for ii=1:qntE
    subplot(5,2,ii);
    plot(C4Ef, C4EXM(ii, :));
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 100]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(C4f, C4XM);
end

%% Bandas de Frequencia - Valores em Hz
delta =     [   0,  3.5];
teta =      [ 3.5,  7.5];
alpha =     [ 7.5, 12.5];
beta =      [12.5, 30.0];
gama =      [30.0, 80.0];
high_gama = [80.0,100.0];

%% Power total
C3PWR = integral(C3XM(C3f < 100), C3f(C3f < 100));
C4PWR = integral(C4XM(C4f < 100), C4f(C4f < 100));

%% Power per band C3
C3PWR_delta = integral(C3XM(C3f > delta(1) & C3f < delta(2)), C3f(C3f > delta(1) & C3f < delta(2)));
C3PWR_teta = integral(C3XM(C3f > teta(1) & C3f < teta(2)), C3f(C3f > teta(1) & C3f < teta(2)));
C3PWR_alpha = integral(C3XM(C3f > alpha(1) & C3f < alpha(2)), C3f(C3f > alpha(1) & C3f < alpha(2)));
C3PWR_beta = integral(C3XM(C3f > beta(1) & C3f < beta(2)), C3f(C3f > beta(1) & C3f < beta(2)));
C3PWR_gama = integral(C3XM(C3f > gama(1) & C3f < gama(2)), C3f(C3f > gama(1) & C3f < gama(2)));
C3PWR_high_gama = integral(C3XM(C3f > high_gama(1) & C3f < high_gama(2)), C3f(C3f > high_gama(1) & C3f < high_gama(2)));
%%
C3_tabela = {'delta', 'teta', 'alpha', 'beta', 'gama', 'high_gama'; ...
    C3PWR_delta, C3PWR_teta, C3PWR_alpha, C3PWR_beta, C3PWR_gama, C3PWR_high_gama};
%% Power per band C4
C4PWR_delta = integral(C4XM(C4f > delta(1) & C4f > delta(2)), C4f(C4f > delta(1) & C4f > delta(2)));
C4PWR_teta = integral(C4XM(C4f > teta(1) & C4f > teta(2)), C4f(C4f > teta(1) & C4f > teta(2)));
C4PWR_alpha = integral(C4XM(C4f > alpha(1) & C4f > alpha(2)), C4f(C4f > alpha(1) & C4f > alpha(2)));
C4PWR_beta = integral(C4XM(C4f > beta(1) & C4f > beta(2)), C4f(C4f > beta(1) & C4f > beta(2)));
C4PWR_gama = integral(C4XM(C4f > gama(1) & C4f > gama(2)), C4f(C4f > gama(1) & C4f > gama(2)));
C4PWR_high_gama = integral(C4XM(C4f > high_gama(1) & C4f > high_gama(2)), C4f(C4f > high_gama(1) & C4f > high_gama(2)));
%%
C4_tabela = {'delta', 'teta', 'alpha', 'beta', 'gama', 'high_gama'; ...
    C4PWR_delta, C4PWR_teta, C4PWR_alpha, C4PWR_beta, C4PWR_gama, C4PWR_high_gama};
%%
tabela = {'-', 'delta', 'teta', 'alpha', 'beta', 'gama', 'high_gama'; ...
    'C3: ', C3PWR_delta, C3PWR_teta, C3PWR_alpha, C3PWR_beta, C3PWR_gama, C3PWR_high_gama; ...
    'C4: ', C4PWR_delta, C4PWR_teta, C4PWR_alpha, C4PWR_beta, C4PWR_gama, C4PWR_high_gama};
%% Para cada epoca
C3EPWR = zeros(qntE, 1);
C4EPWR = zeros(qntE, 1);
for ii=1:qntE
    C3EPWR(ii) = integral(C3EXM(ii, C3Ef < 100), C3Ef(C3Ef < 100));
    C4EPWR(ii) = integral(C4EXM(ii, C4Ef < 100), C4Ef(C4Ef < 100));
end

%% Power per band C3 - Para cada epoca
C3EPWR_delta = zeros(qntE, 1);
C3EPWR_teta = zeros(qntE, 1);
C3EPWR_alpha = zeros(qntE, 1);
C3EPWR_beta = zeros(qntE, 1);
C3EPWR_gama = zeros(qntE, 1);
C3EPWR_high_gama = zeros(qntE, 1);

index_delta = (C3Ef > delta(1) & C3Ef > delta(2));
index_teta = (C3Ef > teta(1) & C3Ef > teta(2));
index_alpha = (C3Ef > alpha(1) & C3Ef > alpha(2));
index_beta = (C3Ef > beta(1) & C3Ef > beta(2));
index_gama = (C3Ef > gama(1) & C3Ef > gama(2));
index_high_gama = (C3Ef > high_gama(1) & C3Ef > high_gama(2));
for ii=1:qntE
    C3EPWR_delta(ii) = integral(C3EXM(ii, index_delta), C3Ef(index_delta));
    C3EPWR_teta(ii) = integral(C3EXM(ii, index_teta), C3Ef(index_teta));
    C3EPWR_alpha(ii) = integral(C3EXM(ii, index_alpha), C3Ef(index_alpha));
    C3EPWR_beta(ii) = integral(C3EXM(ii, index_beta), C3Ef(index_beta));
    C3EPWR_gama(ii) = integral(C3EXM(ii, index_gama), C3Ef(index_gama));
    C3EPWR_high_gama(ii) = integral(C3EXM(ii, index_high_gama), C3Ef(index_high_gama));
end

%% Power per band C4 - Para cada epoca
C4EPWR_delta = zeros(qntE, 1);
C4EPWR_teta = zeros(qntE, 1);
C4EPWR_alpha = zeros(qntE, 1);
C4EPWR_beta = zeros(qntE, 1);
C4EPWR_gama = zeros(qntE, 1);
C4EPWR_high_gama = zeros(qntE, 1);

index_delta = (C4Ef > delta(1) & C4Ef > delta(2));
index_teta = (C4Ef > teta(1) & C4Ef > teta(2));
index_alpha = (C4Ef > alpha(1) & C4Ef > alpha(2));
index_beta = (C4Ef > beta(1) & C4Ef > beta(2));
index_gama = (C4Ef > gama(1) & C4Ef > gama(2));
index_high_gama = (C4Ef > high_gama(1) & C4Ef > high_gama(2));
for ii=1:qntE
    C4EPWR_delta(ii) = integral(C4EXM(ii, index_delta), C4Ef(index_delta));
    C4EPWR_teta(ii) = integral(C4EXM(ii, index_teta), C4Ef(index_teta));
    C4EPWR_alpha(ii) = integral(C4EXM(ii, index_alpha), C4Ef(index_alpha));
    C4EPWR_beta(ii) = integral(C4EXM(ii, index_beta), C4Ef(index_beta));
    C4EPWR_gama(ii) = integral(C4EXM(ii, index_gama), C4Ef(index_gama));
    C4EPWR_high_gama(ii) = integral(C4EXM(ii, index_high_gama), C4Ef(index_high_gama));
end

%%

%% Potencias
%   * Absoluta -> valor bruto da potencia
%   * Potencia relativa
%       * relativo a potencia total da propria epoca
%       * relativo a potencia total do sinal
%       * relativo a soma das potencias de todas as epoca
%       * relativo a varios exemplos
% PCP -> porcentagem de contribui��o de potencia (potencia relativa a cada
% epoca)
%% Aula 28-06-2018

C3PWR_delta_erro = abs((C3PWR_delta - mean(C3EPWR_delta)) / C3PWR_delta);
C3PWR_teta_erro = abs((C3PWR_teta - mean(C3EPWR_teta)) / C3PWR_teta);
C3PWR_alpha_erro = abs((C3PWR_alpha - mean(C3EPWR_alpha)) / C3PWR_alpha);
C3PWR_beta_erro = abs((C3PWR_beta - mean(C3EPWR_beta)) / C3PWR_beta);
C3PWR_gama_erro = abs((C3PWR_gama - mean(C3EPWR_gama)) / C3PWR_gama);
C3PWR_high_gama_erro = abs((C3PWR_high_gama - mean(C3EPWR_high_gama)) / C3PWR_high_gama);

C4PWR_delta_erro = abs((C4PWR_delta - mean(C4EPWR_delta)) / C4PWR_delta);
C4PWR_teta_erro = abs((C4PWR_teta - mean(C4EPWR_teta)) / C4PWR_teta);
C4PWR_alpha_erro = abs((C4PWR_alpha - mean(C4EPWR_alpha)) / C4PWR_alpha);
C4PWR_beta_erro = abs((C4PWR_beta - mean(C4EPWR_beta)) / C4PWR_beta);
C4PWR_gama_erro = abs((C4PWR_gama - mean(C4EPWR_gama)) / C4PWR_gama);
C4PWR_high_gama_erro = abs((C4PWR_high_gama - mean(C4EPWR_high_gama)) / C4PWR_high_gama);


destro_tabela = ...
    {'-', 'delta',     'teta',     'alpha',    'beta',     'gama',     'high_gama'; ...
    'C3_total: ', C3PWR_delta, C3PWR_teta, C3PWR_alpha, C3PWR_beta, C3PWR_gama, C3PWR_high_gama; ...
    'C3_media: ', mean(C3EPWR_delta), mean(C3EPWR_teta), mean(C3EPWR_alpha), mean(C3EPWR_beta), mean(C3EPWR_gama), mean(C3EPWR_high_gama); ...
    'C3_erro: ', C3PWR_delta_erro, C3PWR_teta_erro, C3PWR_alpha_erro, C3PWR_beta_erro, C3PWR_gama_erro, C3PWR_high_gama_erro; ...
    'C4_total: ', C4PWR_delta, C4PWR_teta, C4PWR_alpha, C4PWR_beta, C4PWR_gama, C4PWR_high_gama; ...
    'C4_media: ', mean(C4EPWR_delta), mean(C4EPWR_teta), mean(C4EPWR_alpha), mean(C4EPWR_beta), mean(C4EPWR_gama), mean(C4EPWR_high_gama); ...
    'C4_erro: ', C4PWR_delta_erro, C4PWR_teta_erro, C4PWR_alpha_erro, C4PWR_beta_erro, C4PWR_gama_erro, C4PWR_high_gama_erro};
