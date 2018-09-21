function [concentration_value, bands_freq_pwr] = get_concentration_value(eeg_freqs, eeg_powers, modo)
%GET_FREQ_BANDS_POWER Summary of this function goes here
%   Detailed explanation goes here
    
    df = eeg_freqs(2) - eeg_freqs(1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Método TRAPEZOIDAL implementado pelo matlab
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(modo, 'trapz')
        SMR =   df*trapz(eeg_powers(:, eeg_freqs >= 12 & eeg_freqs < 15),2);
        mBeta = df*trapz(eeg_powers(:, eeg_freqs >= 16 & eeg_freqs < 20),2);
        teta =  df*trapz(eeg_powers(:, eeg_freqs >=  4 & eeg_freqs <  7),2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Método através da média dos valores
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(modo, 'mean')
        SMR =   mean(eeg_powers(:, eeg_freqs >= 12 & eeg_freqs < 15),2);
        mBeta = mean(eeg_powers(:, eeg_freqs >= 16 & eeg_freqs < 20),2);
        teta =  mean(eeg_powers(:, eeg_freqs >=  4 & eeg_freqs <  7),2);
    end
    
    concentration_value = (SMR + mBeta) ./ teta;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % salvando resultado final
    bands_freq_pwr = [SMR, mBeta, teta];
end

function [] = plot_freq_bands_power(eeg_freqs, eeg_powers)
    eeg_powers = eeg_powers(1,:) / max(eeg_powers(1,:));
%     delta_s =  eeg_powers(:, eeg_freqs >     0 & eeg_freqs <   3.5);
%     delta_f =  eeg_freqs(    eeg_freqs >     0 & eeg_freqs <   3.5);
%     
%     teta_s =   eeg_powers(:, eeg_freqs >=  3.5 & eeg_freqs <   7.5);
%     teta_f =   eeg_freqs(    eeg_freqs >=  3.5 & eeg_freqs <   7.5);
%     
%     alpha_s =  eeg_powers(:, eeg_freqs >=  7.5 & eeg_freqs <  12.5);
%     alpha_f =  eeg_freqs(    eeg_freqs >=  7.5 & eeg_freqs <  12.5);
%     
%     beta_s =   eeg_powers(:, eeg_freqs >= 12.5 & eeg_freqs <  30.0);
%     beta_f =   eeg_freqs(    eeg_freqs >= 12.5 & eeg_freqs <  30.0);
%     
%     gama_s =   eeg_powers(:, eeg_freqs >= 30.0 & eeg_freqs <  80.0);
%     gama_f =   eeg_freqs(    eeg_freqs >= 30.0 & eeg_freqs <  80.0);
%     
%     s_gama_s = eeg_powers(:, eeg_freqs >= 80.0 & eeg_freqs < 100.0);
%     s_gama_f = eeg_freqs(    eeg_freqs >= 80.0 & eeg_freqs < 100.0);
      
    delta_s =  eeg_powers(:, eeg_freqs >=  0 & eeg_freqs <   4);
    delta_f =  eeg_freqs(    eeg_freqs >=  0 & eeg_freqs <   4);
    
    teta_s =   eeg_powers(:, eeg_freqs >=  4 & eeg_freqs <   8);
    teta_f =   eeg_freqs(    eeg_freqs >=  4 & eeg_freqs <   8);
    
    alpha_s =  eeg_powers(:, eeg_freqs >=  8 & eeg_freqs <  16);
    alpha_f =  eeg_freqs(    eeg_freqs >=  8 & eeg_freqs <  16);
    
    beta_s =   eeg_powers(:, eeg_freqs >= 16 & eeg_freqs <  32);
    beta_f =   eeg_freqs(    eeg_freqs >= 16 & eeg_freqs <  32);
    
    gama_s =   eeg_powers(:, eeg_freqs >= 32 & eeg_freqs <  64);
    gama_f =   eeg_freqs(    eeg_freqs >= 32 & eeg_freqs <  64);
    
    s_gama_s = eeg_powers(:, eeg_freqs >= 64 & eeg_freqs < 100);
    s_gama_f = eeg_freqs(    eeg_freqs >= 64 & eeg_freqs < 100);
    
    
    figure();
    plot(eeg_freqs, eeg_powers(1, :)); hold on;
    plot(delta_f, delta_s(1, :));
    plot(teta_f, teta_s(1, :));
    plot(alpha_f, alpha_s(1, :));
    plot(beta_f, beta_s(1, :));
    plot(gama_f, gama_s(1, :));
    plot(s_gama_f, s_gama_s(1, :));
end