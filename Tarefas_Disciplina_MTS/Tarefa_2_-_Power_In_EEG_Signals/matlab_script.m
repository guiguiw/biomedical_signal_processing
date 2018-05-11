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
% 'C42' 'T81'   'T3—'   'P31'   'Pz2'   'P42'   'T41'   'O31'   'Oz2'   'O42'
% 21
% 'Cz2'
%
% Em aula foram utilizados os eletrodos 14 e 16. (P31 e P42)

%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro')

%% Clearing the enviroment
clear; close all; clc;

%% Loading the data
load('EEG_Metrologia.mat');

%% Choosing 2 Electrodes
P3 = xn(14, :);
P4 = xn(16, :);

%% Optional: Plotting the data
subplot(2,1,1);
plot(t, P3);
title('Loaded Data - P3');

subplot(2,1,2);
plot(t, P4);
title('Loaded Data - P4');

%% Splitting the data
% Vetor do inicio das epocas
t_epocas = [2, 6, 13, 23, 34, 51, 80, 108, 118, 165];
qnt_epocas = length(t_epocas);
d_epocas = 2;
P3_epocas = zeros(qnt_epocas, d_epocas * fa + 1);
P4_epocas = zeros(qnt_epocas, d_epocas * fa + 1);
for ii=1:qnt_epocas
    P3_epocas(ii,:) = P3(1, (t_epocas(ii)*fa):((t_epocas(ii) + d_epocas)*fa));
    P4_epocas(ii,:) = P4(1, (t_epocas(ii)*fa):((t_epocas(ii) + d_epocas)*fa));
end
t_cada_epoca = 0:T:d_epocas;
%% Auto Correlation Matriz

[P3Rx, P3Tx] = autocorr_matriz(P3, fa);
[P4Rx, P4Tx] = autocorr_matriz(P4, fa);

%% Oprtional: Plotting the 'epocas'
figure('NumberTitle', 'off', 'Name', 'Epocas de P3');
for ii=1:qnt_epocas
    subplot(5,2,ii);
    plot(t_cada_epoca, P3_epocas(ii, :));
    title(['Epoca: ' int2str(t_epocas(ii)) ' s']);
end
figure('NumberTitle', 'off', 'Name', 'Epocas de P4');
for ii=1:qnt_epocas
    subplot(5,2,ii);
    plot(t_cada_epoca, P4_epocas(ii, :));
    title(['Epoca: ' int2str(t_epocas(ii)) ' s']);
end

%% Calculating PSD (Power Spectrum Density)
[P3XM, P3XF, P3f] = DFT(P3Rx, P3Tx, 1/(P3Tx(2) - P3Tx(1)));

%% Plotting

plot(P3f, P3XM);
title("PSD - Power Spectrum Density");
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
