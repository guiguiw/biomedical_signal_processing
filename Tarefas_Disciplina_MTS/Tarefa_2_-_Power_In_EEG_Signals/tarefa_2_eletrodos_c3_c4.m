% ------------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering Lab
% ------------------------------------------------------------------------------
% Author: Italo Gustavo Sampaio Fernandes
% Contact: italogsfernandes@gmail.com
% Git: www.github.com/italogfernandes
% ---------------------d---------------------------------------------------------
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

%% Cleanning
clear('canais_ordem', 'info_variaveis', 'N', 'n_canais', 'tempo_total', 'xn');

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
epochs = zeros(size(C3));
qntE = length(tE);
dE = 2;
C3E = zeros(qntE, dE * fa + 1);
C4E = zeros(qntE, dE * fa + 1);
for ii=1:qntE
    C3E(ii,:) = C3(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
    C4E(ii,:) = C4(1, (tE(ii)*fa):((tE(ii) + dE)*fa));
    epochs((tE(ii)*fa):((tE(ii) + dE)*fa)) = ones(1,dE * fa + 1);
end
t_cada_epoca = 0:T:dE;

%% Oprtional: Plotting the data with the epochs
subplot(2,1,1);
plot(t, C3); hold on;
plot(t, epochs*max(C3), 'linewidth', 2);
title('Epocas - C3');
xlabel('Tempo [s]');
ylabel('Tensão [uV]');
grid on;

subplot(2,1,2);
plot(t, C4); hold on;
plot(t, epochs*max(C4), 'linewidth', 2);
title('Epocas - C4');
xlabel('Tempo [s]');
ylabel('Tempo [uV]');
grid on;


%% Auto Correlation Matriz

[C3Rx, C3Tx] = autocorr_matriz(C3, fa);
[C4Rx, C4Tx] = autocorr_matriz(C4, fa);
[C3ERx, C3ETx] = autocorr_matriz(C3E, fa);
[C4ERx, C4ETx] = autocorr_matriz(C4E, fa);

%% Oprtional: Plotting the epoch
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
fig = figure();
set(fig,'Position', [1, 1, 400, 300]);
plot(C3f, C3XM, 'linewidth', 2);
title('Espectro', 'fontsize', 16);
ylabel('|X| [W/Hz]', 'fontsize', 18);
xlabel('F [Hz]', 'fontsize', 18);
xlim([0, 100]);
%hold on;
%plot(C4f, C4XM, 'linewidth', 2);
grid on;
%legend('C3','C4');

%% Optional: Plotting the PSD 
fig = figure();
%set(fig,'Position', [1, 1, 400, 300]);
plot(C3f, C3XM, 'linewidth', 2);
title('Espectro', 'fontsize', 16);
ylabel('|X| [W/Hz]', 'fontsize', 18);
xlabel('F [Hz]', 'fontsize', 18);
xlim([0, 100]);
hold on;
plot(C4f, C4XM, 'linewidth', 2);
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
    plot(C3Ef, C3EXM(ii, :), 'linewidth', 2);
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 30]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(C3f, C3XM, 'linewidth', 2);
    legend('Epoca', 'Total');
end
figure('NumberTitle', 'off', 'Name', 'PSD de C4');
for ii=1:qntE
    subplot(5,2,ii);
    plot(C4Ef, C4EXM(ii, :), 'linewidth', 2);
    ylabel('|X| [W/Hz]');
    xlabel('F [Hz]');
    xlim([0, 30]);
    title(['Epoca: ' int2str(tE(ii)) ' s']);
    grid on;
    hold on; plot(C4f, C4XM, 'linewidth', 2);
    legend('Epoca', 'Total');
end

%% Power total
C3PWR = trapz(C3XM(C3f < 100), C3f(C3f < 100));
C4PWR = trapz(C4XM(C4f < 100), C4f(C4f < 100));

C3EPWR = zeros(qntE, 1);
C4EPWR = zeros(qntE, 1);
for ii=1:qntE
    C3EPWR(ii) = trapz(C3EXM(ii, C3Ef < 100), C3Ef(C3Ef < 100));
    C4EPWR(ii) = trapz(C4EXM(ii, C4Ef < 100), C4Ef(C4Ef < 100));
end

disp('************************');
disp('Usando função TRAPZ');
disp('************************');
disp(['Potência de C3: ' num2str(C3PWR)]);
disp(['Potência de C4: ' num2str(C4PWR)]);
disp('************************');
disp('Potências de cada epoca de C3: ');
C3EPWR'
disp('Potências de cada epoca de C4: ');
C4EPWR'

%% Power total usando equações do destro
C3PWR = integral(C3XM(C3f < 100), C3f(C3f < 100));
C4PWR = integral(C4XM(C4f < 100), C4f(C4f < 100));

C3EPWR = zeros(qntE, 1);
C4EPWR = zeros(qntE, 1);
for ii=1:qntE
    C3EPWR(ii) = integral(C3EXM(ii, C3Ef < 100), C3Ef(C3Ef < 100));
    C4EPWR(ii) = integral(C4EXM(ii, C4Ef < 100), C4Ef(C4Ef < 100));
end

disp('************************');
disp('Usando funções do Destro');
disp('************************');
disp(['Potência de C3: ' num2str(C3PWR)]);
disp(['Potência de C4: ' num2str(C4PWR)]);
disp('************************');
disp('Potências de cada epoca de C3: ');
C3EPWR'*1E6
disp('Potências de cada epoca de C4: ');
C4EPWR'*1E6

%% Erro da PSD de C3
C3XM_mean = mean(C3EXM);
C3XM_std = std(C3EXM);
C3XM_mean_upper = C3XM_mean + C3XM_std;
C3XM_mean_lower = C3XM_mean - C3XM_std;

figure();
plot(C3f, C3XM_mean, 'linewidth', 2);
hold on;
plot(C3f, C3XM, 'linewidth', 2);

plot(C3f, C3XM_mean_upper, 'k');
plot(C3f, C3XM_mean_lower, 'k');
title('Espectro de C3 Total vs C3 Media');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 30]);
grid on;
legend('C3 Media','C3 Total');
%%
find(C3XM > C3XM_mean_upper);
length(find(C3XM < C3XM_mean_lower)) / (length(C3XM)/2)

%% 
figure();

hold on;

plot(C3f, C3XM_mean_upper, 'k');
x2 = [C3f, fliplr(C3f)];
inBetween = [C3XM_mean, fliplr(C3XM_mean_upper)];
fill(x2, inBetween, [0.8 0.8 0.8]);

plot(C3f, C3XM_mean_lower, 'k');
x2 = [C3f, fliplr(C3f)];
inBetween = [C3XM_mean, fliplr(C3XM_mean_lower)];
fill(x2, inBetween, [0.8 0.8 0.8]);

h1 = plot(C3f, C3XM_mean, 'b', 'linewidth', 2);%, 'legend', 'C3 Media');
h2 = plot(C3f, C3XM, 'r', 'linewidth', 2);%, 'legend', 'C3 Total');

title('Espectro de C3 Total vs C3 Media');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 30]);
grid on;
legend([h1 h2],{'C3 Media','C3 Total'});
%legend('','','','','C3 Media','C3 Total');
%% Erro da PSD de C4
C4XM_mean = mean(C4EXM);
C4XM_std = std(C4EXM);
C4XM_mean_upper = C4XM_mean + C4XM_std;
C4XM_mean_lower = C4XM_mean - C4XM_std;

figure();
plot(C4f, C4XM_mean, 'linewidth', 2);
hold on;
plot(C4f, C4XM, 'linewidth', 2);

plot(C4f, C4XM_mean_upper, 'k');
plot(C4f, C4XM_mean_lower, 'k');
title('Espectro de C4 Total vs C4 Media');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 30]);
grid on;
legend('C4 Media','C4 Total');

%% 
figure();

hold on;

plot(C4f, C4XM_mean_upper, 'k');
x2 = [C4f, fliplr(C4f)];
inBetween = [C4XM_mean, fliplr(C4XM_mean_upper)];
fill(x2, inBetween, [0.8 0.8 0.8]);

plot(C4f, C4XM_mean_lower, 'k');
x2 = [C4f, fliplr(C4f)];
inBetween = [C4XM_mean, fliplr(C4XM_mean_lower)];
fill(x2, inBetween, [0.8 0.8 0.8]);

h1 = plot(C4f, C4XM_mean, 'b', 'linewidth', 2);%, 'legend', 'C4 Media');
h2 = plot(C4f, C4XM, 'r', 'linewidth', 2);%, 'legend', 'C4 Total');

title('Espectro de C4 Total vs C4 Media');
ylabel('|X| [W/Hz]');
xlabel('F [Hz]');
xlim([0, 30]);
grid on;
legend([h1 h2],{'C4 Media','C4 Total'});
%legend('','','','','C4 Media','C4 Total');
%%
find(C4XM > C4XM_mean_upper);
length(find(C4XM < C4XM_mean_lower)) / (length(C4XM)/2)

%% Descobrindo o DeltaV do conversor ad

%% potencias
figure()
bar(C3EPWR*1E6)
hold on
plot(C3PWR*1E6*ones(1,10), '-.', 'linewidth', 4)
title("Potências das Épocas de C3")
grid on;
ylabel('Potência [uW]')
xlabel('Época')

figure()
bar(C4EPWR*1E6)
hold on
plot(C4PWR*1E6*ones(1,10), '-.', 'linewidth', 4)
title("Potências das Épocas de C4")
grid on;
ylabel('Potência [uW]')
ylim([0, 300])
xlabel('Época')