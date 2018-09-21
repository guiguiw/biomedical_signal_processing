%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro', '../toolbox')%, '../biolab_toolbox')

%% Clearing the enviroment
clear; close all; clc;

%% Loading the data
load('EEG_Metrologia_2.mat');

%% 10 epocas, 6 bandas, 20 eletrodos
final_results_resting = zeros(10,6,20);
final_results_stimulus = zeros(10,6,20);

for nn=1:20
%% Escolhendo eletrodo
raw_eeg = get_electrode_raw_data(nomeCanais{nn}, xn, nomeCanais);

[b,a] =  butter(4, 0.1/(fa/2), 'high');
raw_eeg = filtfilt(b,a,raw_eeg);
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

%% Frequency Bands
% Descomente a opção desejada
% Media
[rest_total, eeg_resting_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_resting_powers, 'mean');
[stim_total, eeg_stimulus_freq_bands] = get_freq_bands_power(eeg_freqs, eeg_stimulus_powers, 'mean');

%% Relativa
% descomente para obter a frequencia relativa
% ou deixe comentado para opter a frequencia total
% for ii=1:10
%      eeg_resting_freq_bands(ii,:) = eeg_resting_freq_bands(ii,:) / rest_total(ii);
%      eeg_stimulus_freq_bands(ii,:) = eeg_stimulus_freq_bands(ii,:) / stim_total(ii);
% end

%%
final_results_resting(:,:,nn) = eeg_resting_freq_bands;
final_results_stimulus(:,:,nn) = eeg_stimulus_freq_bands;

%%
% rest = mean(eeg_resting_freq_bands)';
% std_rest = std(eeg_resting_freq_bands)';
% stim = mean(eeg_stimulus_freq_bands)';
% std_stim = std(eeg_stimulus_freq_bands)';
% 
% rest_stim = [rest stim];
% rest_stim_std = [std_rest std_stim];

% subplot(5,4,nn);
% bar(rest_stim); hold on;
% index_error_bar = [0.85 1.15; 1.85 2.15; 2.85 3.15; 3.85 4.15; 4.85 5.15; 5.85 6.15];
% errorbar(index_error_bar, rest_stim,rest_stim_std,'k.')
% title(nomeCanais{nn});
% %title("Potências Totais para C3 - media");
% %legend('Respouso', 'Estimulo');
% ylabel("Potência Total");
% xlabel("Bandas de Frequência");
% grid on;
% %ylim([0, 40]);
% set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
end
%% 
