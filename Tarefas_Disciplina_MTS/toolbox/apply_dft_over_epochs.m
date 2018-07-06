function [eeg_freqs, eeg_powers] = apply_dft_over_epochs(eeg_epochs,fa, qnt_epochs)
%APPLY_DFT_OVER_EPOCHS Summary of this function goes here
%   Detailed explanation goes here
    [eeg_freqs, eeg_powers] = dft_simplified(eeg_epochs(1,:), fa);
    eeg_powers = zeros(qnt_epochs, length(eeg_powers));
    for ii=1:qnt_epochs
        [~, eeg_powers(ii,:)] = dft_simplified(eeg_epochs(ii,:), fa);
    end
end

