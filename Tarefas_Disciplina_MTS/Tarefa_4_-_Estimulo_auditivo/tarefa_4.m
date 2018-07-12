%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro', '../toolbox')%, '../biolab_toolbox')

%% Clearing the enviroment
clear; close all; clc;

%% Loading the data
load('EEG_Metrologia_2.mat');


%for nn=1:20
%% Escolhendo eletrodo
%raw_eeg = get_electrode_raw_data(nomeCanais{nn}, xn, nomeCanais);
raw_eeg = get_electrode_raw_data('C3', xn, nomeCanais);
%subplot(2,1,1);
%plot(t, raw_eeg);hold on;
%xlim([0, 1]);

[b,a] =  butter(4, 0.1/(fa/2), 'high');
raw_eeg = filtfilt(b,a,raw_eeg);

%grid on;
%subplot(2,1,2);
%plot(t, raw_eeg);
%xlim([0, 1]);
%%
%figure()
%[freqs, pows] = dft_simplified(raw_eeg,fa);
%plot(freqs, pows);
%% Selecting Epochs
qnt_epochs = 10;
epoch_rest = ['00:02'; '00:14'; '00:23'; '00:42'; '01:01'; '01:20'; '01:39'; '01:58'; '02:17'; '02:39'];
epoch_stimulus = ['03:01'; '03:05'; '03:13'; '03:17'; '03:21'; '03:38'; '03:42'; '03:48'; '03:51'; '03:55'];

%% Spliting in epochs
eeg_resting_epochs = split_data_in_epochs(raw_eeg, epoch_rest, 10, 2, fa);
eeg_stimulus_epochs = split_data_in_epochs(raw_eeg, epoch_stimulus, 10, 2, fa);

%% Applying Fourier Transofrm
[eeg_freqs, eeg_resting_powers] = apply_dft_over_epochs(eeg_resting_epochs, fa, qnt_epochs);
[~, eeg_stimulus_powers] = apply_dft_over_epochs(eeg_stimulus_epochs, fa, qnt_epochs);

% I'm only concerned about the freqs between 0 Hz and 100 Hzfoi
eeg_freqs = eeg_freqs(eeg_freqs < 100);
eeg_resting_powers = eeg_resting_powers(:, eeg_freqs < 100);
eeg_stimulus_powers = eeg_stimulus_powers(:, eeg_freqs < 100);
%%
plot(eeg_freqs, eeg_stimulus_powers(1,:));

%% potencia
% plot(eeg_freqs, eeg_resting_powers(1, :));
% title('fft');
%% Frequency Bands
% Descomente a opção desejada

% Trapezoidal
% [rest_total, eeg_resting_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_resting_powers, 'trapz');
% [stim_total, eeg_stimulus_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_stimulus_powers, 'trapz');
 
% Media
% [rest_total, eeg_resting_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_resting_powers, 'mean');
% [stim_total, eeg_stimulus_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_stimulus_powers, 'mean');
 
% integral.m corrigida
% [rest_total, eeg_resting_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_resting_powers, 'destro_corrigida');
% [stim_total, eeg_stimulus_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_stimulus_powers, 'destro_corrigida');
 
% Integral.m com todos os erros que tinha
[rest_total, eeg_resting_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_resting_powers, 'destro');
[stim_total, eeg_stimulus_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_stimulus_powers, 'destro');
%% Relativa
% for ii=1:10
%      eeg_resting_freq_bands(ii,:) = eeg_resting_freq_bands(ii,:) / rest_total(ii);
%      eeg_stimulus_freq_bands(ii,:) = eeg_stimulus_freq_bands(ii,:) / stim_total(ii);
% end
%% 3d
figure()
[X,Y] = meshgrid(1:10,eeg_freqs);
Z =  eeg_stimulus_powers';

s = surf(X,Y,Z);
xlim([1,10])
s.EdgeColor = 'none';
xlabel('Tempo');
ylabel('Frequência');
zlabel('Power');
set(gca,'YTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
%%
%nomes_bandas = categorical{{'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'}};
% bar(eeg_resting_freq_bands(1, :))
% title('...');
% set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
%%
rest = mean(eeg_resting_freq_bands)';
std_rest = std(eeg_resting_freq_bands)';
stim = mean(eeg_stimulus_freq_bands)';
std_stim = std(eeg_stimulus_freq_bands)';

rest_stim = [rest stim];
rest_stim_std = [std_rest std_stim];

%subplot(5,4,nn);
bar(rest_stim); hold on;
index_error_bar = [0.85 1.15; 1.85 2.15; 2.85 3.15; 3.85 4.15; 4.85 5.15; 5.85 6.15];
errorbar(index_error_bar, rest_stim,rest_stim_std,'k.')
%title(nomeCanais{nn});
title("Potências Totais para C3 - media");
legend('Respouso', 'Estimulo');
ylabel("Potência Total");
xlabel("Bandas de Frequência");
grid on;
%ylim([0, 40]);
set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
%end
%% 
