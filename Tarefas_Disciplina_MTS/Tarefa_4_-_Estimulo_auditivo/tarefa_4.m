%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro', '../toolbox')

%% Clearing the enviroment
clear; close all; clc;

%% Loading the data
load('EEG_Metrologia_2.mat');

%% Escolhendo eletrodo
raw_eeg = get_electrode_raw_data('C3', xn, nomeCanais);

%% Selecting Epochs
qnt_epocas = 10;
epoch_rest = ['00:02'; '00:14'; '00:23'; '00:42'; '01:01'; '01:20'; '01:39'; '01:58'; '02:17'; '02:39'];
epoch_stimulus = ['03:01'; '03:05'; '03:13'; '03:17'; '03:21'; '03:38'; '03:42'; '03:48'; '03:51'; '03:55'];

%% Spliting in epochs
eeg_resting_epochs = split_data_in_epochs(raw_eeg, epoch_rest, 10, 2, fa);
eeg_stimulus_epochs = split_data_in_epochs(raw_eeg, epoch_stimulus, 10, 2, fa);

%% Autocorrelation Matriz
%xablaus

%% Applying Fourier Transofrm
xablaus = fft(raw_eeg, 
[C3XM, ~, C3f] = DFT(C3Rx, C3Tx, 1/(C3Tx(2) - C3Tx(1)));
[C4XM, ~, C4f] = DFT(C4Rx, C4Tx, 1/(C4Tx(2) - C4Tx(1)));


%%


aa
