%% Adding the path to the Destro's codes and .mat files
addpath('../datasets','../codigos_destro', '../toolbox')%, '../biolab_toolbox')

%% Clearing the enviroment
clear; close all; clc;

%% Applying Fourier Transofrm
eeg_freqs = linspace(0,100, 201);
eeg_powers = zeros(size(eeg_freqs));
index_delta = eeg_freqs >=    0 & eeg_freqs <   3.5;
index_teta = eeg_freqs >=  3.5 & eeg_freqs <   7.5;
index_alpha = eeg_freqs >=  7.5 & eeg_freqs <  12.5;
index_beta = eeg_freqs >= 12.5 & eeg_freqs <  30.0;
index_gama = eeg_freqs >= 30.0 & eeg_freqs <  80.0;
index_s_gama = eeg_freqs >= 80.0 & eeg_freqs < 100.0;
index_totais = eeg_freqs >=    0 & eeg_freqs < 100.0;

%%
eeg_powers(index_delta) = 6;
eeg_powers(index_teta) = 5;
eeg_powers(index_alpha) = 4;
eeg_powers(index_beta) = 3;
eeg_powers(index_gama) = 2;
eeg_powers(index_s_gama) = 1;

%% 
plot(eeg_freqs, eeg_powers)
grid on;
title('Sinal simulado');
xlabel('Frequência (Hz)');
ylabel('Valores simulados');

%% Valores reais
valores_base_x =  [3.5 - 0, 7.5 - 3.5, 12.5 - 7.5, 30 - 12.5, 80 - 30, 100 - 80];
%valores_base_x =  [3.5, 4, 5, 17.5, 50, 20];
valor_altura_y = [6, 5, 4, 3, 2, 1];

areas_simuladas = valores_base_x .* valor_altura_y;


%% Plotando valores reais
bar(areas_simuladas);
title("Áreas Simuladas");
ylim([0, 120]);
ylabel("Áreas");
xlabel("Bandas de Frequência");
grid on;
set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
for ii=1:6
    conta_em_str = [ '  ', num2str(valores_base_x(ii),'%0.1f'), newline,'x', ...
                     num2str(valor_altura_y(ii),'%0.1f'), newline, ...
                     '= ', num2str(areas_simuladas(ii),'%0.1f')];
    text(ii,areas_simuladas(ii), conta_em_str,...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
%% trapezoidal
df = eeg_freqs(2) - eeg_freqs(1);
delta_pwr =  df*trapz(eeg_powers(eeg_freqs >=    0 & eeg_freqs <   3.5));
teta_pwr =   df*trapz(eeg_powers(eeg_freqs >=  3.5 & eeg_freqs <   7.5));
alpha_pwr =  df*trapz(eeg_powers(eeg_freqs >=  7.5 & eeg_freqs <  12.5));
beta_pwr =   df*trapz(eeg_powers(eeg_freqs >= 12.5 & eeg_freqs <  30.0));
gama_pwr =   df*trapz(eeg_powers(eeg_freqs >= 30.0 & eeg_freqs <  80.0));
s_gama_pwr = df*trapz(eeg_powers(eeg_freqs >= 80.0 & eeg_freqs < 100.0));

areas_trapz = [delta_pwr,teta_pwr, alpha_pwr, beta_pwr, gama_pwr, s_gama_pwr];

%% Plotando valores trapz
bar(areas_trapz);
title("Áreas pela função trapz");
ylim([0, 120]);
ylabel("Áreas");
xlabel("Bandas de Frequência");
grid on;
set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
for ii=1:6
    conta_em_str = num2str(areas_trapz(ii),'%0.1f');
    text(ii,areas_trapz(ii), conta_em_str,...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end

%% integral.m
df = eeg_freqs(2) - eeg_freqs(1);
delta_pwr =  df*trapz(eeg_powers(eeg_freqs >=    0 & eeg_freqs <   3.5));
teta_pwr =   df*trapz(eeg_powers(eeg_freqs >=  3.5 & eeg_freqs <   7.5));
alpha_pwr =  df*trapz(eeg_powers(eeg_freqs >=  7.5 & eeg_freqs <  12.5));
beta_pwr =   df*trapz(eeg_powers(eeg_freqs >= 12.5 & eeg_freqs <  30.0));
gama_pwr =   df*trapz(eeg_powers(eeg_freqs >= 30.0 & eeg_freqs <  80.0));
s_gama_pwr = df*trapz(eeg_powers(eeg_freqs >= 80.0 & eeg_freqs < 100.0));

areas_trapz = [delta_pwr,teta_pwr, alpha_pwr, beta_pwr, gama_pwr, s_gama_pwr];

%% plotando integral.m
bar(areas_trapz);
title("Áreas pela função trapz");
ylim([0, 120]);
ylabel("Áreas");
xlabel("Bandas de Frequência");
grid on;
set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
for ii=1:6
    conta_em_str = num2str(areas_trapz(ii),'%0.1f');
    text(ii,areas_trapz(ii), conta_em_str,...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end

%% Plotando
todos_valores = [rest stim];
bar(rest_stim);

title("Áreas Caluladas pelos diferentes métodos");
legend('Real', 'Trapz', 'integral.m');
ylabel("Áreas");
xlabel("Bandas de Frequência");
grid on;

set(gca,'XTickLabel', {'delta', 'teta', 'alpha', 'beta', 'gama', 's gama'});
