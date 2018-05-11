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
xlabel('Time [s]');
ylabel('Tensão [uV]');
grid on;

subplot(2,1,2);
plot(t, P4);
title('Loaded Data - P4');
xlabel('Time [s]');
ylabel('Tensão [uV]');
grid on;

%% Splitting the data
% Vetor do inicio das epocas
tE = [2, 6, 13, 23, 34, 51, 80, 108, 118, 165];
qntE = length(tE);
dE = 2;
P3E = zeros(qntE, dE * fa + 1);
P4E = zeros(qntE, dE * fa + 1);
for ii=1:qntE
    P3E(ii,:) = P3(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
    P4E(ii,:) = P4(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
end
t_cada_epoca = 0:T:dE;
%% Auto Correlation Matriz

[P3Rx, P3Tx] = autocorr_matriz(P3, fa);
[P4Rx, P4Tx] = autocorr_matriz(P4, fa);
[P3ERx, P3ETx] = autocorr_matriz(P3E, fa);
[P4ERx, P4ETx] = autocorr_matriz(P4E, fa);

%% Oprtional: Plotting the 'epocas'
figure('NumberTitle', 'off', 'Name', 'Epocas de P3');
for ii=1:qntE
    subplot(5,2,ii);
    plot(t_cada_epoca, P3E(ii, :));
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
end
figure('NumberTitle', 'off', 'Name', 'Epocas de P4');
for ii=1:qntE
    subplot(5,2,ii);
    plot(t_cada_epoca, P4E(ii, :));
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
end

%% Calculating PSD (Power Spectrum Density)
[P3XM, ~, P3f] = DFT(P3Rx, P3Tx, 1/(P3Tx(2) - P3Tx(1)));
[P4XM, ~, P4f] = DFT(P4Rx, P4Tx, 1/(P4Tx(2) - P4Tx(1)));
% Corrigindo a tensão com 10-9
% TODO: Explicar o porque desse fator de correção
P3XM = P3XM .* 10E-9;
P4XM = P4XM .* 10E-9;

%% Calculating PSD (Power Spectrum Density) "Epocas"
[P3EXM, ~, P3Ef] = DFT(P3ERx, P3ETx, 1/(P3ETx(2) - P3ETx(1)));
[P4EXM, ~, P4Ef] = DFT(P4ERx, P4ETx, 1/(P4ETx(2) - P4ETx(1)));
% Corrigindo a tensão com 10-9
% TODO: Explicar o porque desse fator de correção
P3EXM = P3EXM .* 10E-9;
P4EXM = P4EXM .* 10E-9;

%% Optional: Plotting the PSD 
figure();
plot(P3f, P3XM);
title('PSD - Power Spectrum Density');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 100]);
hold on;
plot(P4f, P4XM);
grid on;
legend('P3','P4');

%% Optional: Plotting the PSD (Epocas)
% TODO: falar por que ele normaliza todas as epocas
figure();
plot(P3Ef, P3EXM);
title('PSD - Power Spectrum Density of All');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 100]);
grid on;

%% Oprtional: Plotting the 'epocas'
figure('NumberTitle', 'off', 'Name', 'PSD de P3');
for ii=1:qntE
    subplot(5,2,ii);
    plot(P3Ef, P3EXM(ii, :));
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 100]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(P3f, P3XM);
end
figure('NumberTitle', 'off', 'Name', 'PSD de P4');
for ii=1:qntE
    subplot(5,2,ii);
    plot(P4Ef, P4EXM(ii, :));
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 100]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(P4f, P4XM);
end
%% Total power
P3PWR = trapz(P3XM(P3f < 100), P3f(P3f < 100));
P4PWR = trapz(P4XM(P4f < 100), P4f(P4f < 100));

P3EPWR = zeros(qntE, 1);
P4EPWR = zeros(qntE, 1);
for ii=1:qntE
    P3EPWR(ii) = trapz(P3EXM(ii, P3Ef < 100), P3Ef(P3Ef < 100));
    P4EPWR(ii) = trapz(P4EXM(ii, P4Ef < 100), P4Ef(P4Ef < 100));
end


