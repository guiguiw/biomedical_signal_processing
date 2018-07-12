function [pot_totais, bands_freq_pwr] = get_freq_bands_power(eeg_freqs, eeg_powers, modo)
%GET_FREQ_BANDS_POWER Summary of this function goes here
%   Detailed explanation goes here
    %plot_freq_bands_power(eeg_freqs, eeg_powers);
    df = eeg_freqs(2) - eeg_freqs(1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Método TRAPEZOIDAL implementado pelo matlab
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(modo, 'trapz')
        delta_pwr =  df*trapz(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs <   3.5),2);
        teta_pwr =   df*trapz(eeg_powers(:, eeg_freqs >=  3.5 & eeg_freqs <   7.5),2);
        alpha_pwr =  df*trapz(eeg_powers(:, eeg_freqs >=  7.5 & eeg_freqs <  12.5),2);
        beta_pwr =   df*trapz(eeg_powers(:, eeg_freqs >= 12.5 & eeg_freqs <  30.0),2);
        gama_pwr =   df*trapz(eeg_powers(:, eeg_freqs >= 30.0 & eeg_freqs <  80.0),2);
        s_gama_pwr = df*trapz(eeg_powers(:, eeg_freqs >= 80.0 & eeg_freqs < 100.0),2);
        pot_totais = df*trapz(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs < 100.0),2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Método através da média dos valores
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(modo, 'mean')
        delta_pwr =  mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs <   3.5),2);
        teta_pwr =   mean(eeg_powers(:, eeg_freqs >=  3.5 & eeg_freqs <   7.5),2);
        alpha_pwr =  mean(eeg_powers(:, eeg_freqs >=  7.5 & eeg_freqs <  12.5),2);
        beta_pwr =   mean(eeg_powers(:, eeg_freqs >= 12.5 & eeg_freqs <  30.0),2);
        gama_pwr =   mean(eeg_powers(:, eeg_freqs >= 30.0 & eeg_freqs <  80.0),2);
        s_gama_pwr = mean(eeg_powers(:, eeg_freqs >= 80.0 & eeg_freqs < 100.0),2);
        pot_totais = mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs < 100.0),2);
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Arquivo integral.m do Destro corrigido
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(modo, 'destro_corrigida')
        delta_pwr =  mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs <   3.5),2);
        teta_pwr =   mean(eeg_powers(:, eeg_freqs >=  3.5 & eeg_freqs <   7.5),2);
        alpha_pwr =  mean(eeg_powers(:, eeg_freqs >=  7.5 & eeg_freqs <  12.5),2);
        beta_pwr =   mean(eeg_powers(:, eeg_freqs >= 12.5 & eeg_freqs <  30.0),2);
        gama_pwr =   mean(eeg_powers(:, eeg_freqs >= 30.0 & eeg_freqs <  80.0),2);
        s_gama_pwr = mean(eeg_powers(:, eeg_freqs >= 80.0 & eeg_freqs < 100.0),2);
        pot_totais = mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs < 100.0),2);
        for ii=1:10
            delta_pwr(ii) =  integral(eeg_powers(ii, eeg_freqs >=    0 & eeg_freqs <   3.5),df);
            teta_pwr(ii) =   integral(eeg_powers(ii, eeg_freqs >=  3.5 & eeg_freqs <   7.5),df);
            alpha_pwr(ii) =  integral(eeg_powers(ii, eeg_freqs >=  7.5 & eeg_freqs <  12.5),df);
            beta_pwr(ii) =   integral(eeg_powers(ii, eeg_freqs >= 12.5 & eeg_freqs <  30.0),df);
            gama_pwr(ii) =   integral(eeg_powers(ii, eeg_freqs >= 30.0 & eeg_freqs <  80.0),df);
            s_gama_pwr(ii) = integral(eeg_powers(ii, eeg_freqs >= 80.0 & eeg_freqs < 100.0),df);
            pot_totais(ii) = integral(eeg_powers(ii, eeg_freqs >=    0 & eeg_freqs < 100.0),df);
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Arquivo integral.m do Destro sem a correção
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif strcmp(modo, 'destro')
        delta_pwr =  mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs <   3.5),2);
        teta_pwr =   mean(eeg_powers(:, eeg_freqs >=  3.5 & eeg_freqs <   7.5),2);
        alpha_pwr =  mean(eeg_powers(:, eeg_freqs >=  7.5 & eeg_freqs <  12.5),2);
        beta_pwr =   mean(eeg_powers(:, eeg_freqs >= 12.5 & eeg_freqs <  30.0),2);
        gama_pwr =   mean(eeg_powers(:, eeg_freqs >= 30.0 & eeg_freqs <  80.0),2);
        s_gama_pwr = mean(eeg_powers(:, eeg_freqs >= 80.0 & eeg_freqs < 100.0),2);
        pot_totais = mean(eeg_powers(:, eeg_freqs >=    0 & eeg_freqs < 100.0),2);
        for ii=1:10
            [delta_pwr(ii), ~] =  integral_antiga(eeg_powers(ii, eeg_freqs >=    0 & eeg_freqs <   3.5));
            [teta_pwr(ii), ~] =   integral_antiga(eeg_powers(ii, eeg_freqs >=  3.5 & eeg_freqs <   7.5));
            [alpha_pwr(ii), ~] =  integral_antiga(eeg_powers(ii, eeg_freqs >=  7.5 & eeg_freqs <  12.5));
            [beta_pwr(ii), ~] =   integral_antiga(eeg_powers(ii, eeg_freqs >= 12.5 & eeg_freqs <  30.0));
            [gama_pwr(ii), ~] =   integral_antiga(eeg_powers(ii, eeg_freqs >= 30.0 & eeg_freqs <  80.0));
            [s_gama_pwr(ii), ~] = integral_antiga(eeg_powers(ii, eeg_freqs >= 80.0 & eeg_freqs < 100.0));
            [pot_totais(ii), ~] = integral_antiga(eeg_powers(ii, eeg_freqs >=    0 & eeg_freqs < 100.0));
        end
        delta_pwr = abs(delta_pwr);
        teta_pwr = abs(teta_pwr);
        alpha_pwr = abs(alpha_pwr);
        beta_pwr = abs(beta_pwr);
        gama_pwr = abs(gama_pwr);
        s_gama_pwr = abs(s_gama_pwr);
        pot_totais = abs(pot_totais);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % salvando resultado final
    bands_freq_pwr = [delta_pwr,teta_pwr, alpha_pwr, beta_pwr, gama_pwr, s_gama_pwr];
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