%--------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering
%--------------------------------------------------------------------------
% Author: Italo Gustavo Sampaio Fernandes
% Contact: italogsfernandes@gmail.com
% Git: www.github.com/italogfernandes
%--------------------------------------------------------------------------
% Decription: 
% Entrada:
%    - Arquivo Coma
%    - Tempos iniciais e Finais (ti e tf)
% Saida:
%   - valores1
%   - potencias
%--------------------------------------------------------------------------

close all;

% -------------------------------------------------------------------------
% Select Dataset
% Carrega os aquivos salva em X e libera a memoria
load coma
x = coma; % Arquivo de 20 canais de EEG em [V],durante 10 segundos a 250Hz
Fs = 250; % Frequencia de Amostragem
% Definicao dos tempos de inicio e fim
[ti,tf] = receberTempos(); % Definicao do tempo final
clear coma;

[Q, N] = size(x);
samplePeriod = 1/Fs; % Periodo de Amostragem
t = samplePeriod*(0:(N-1)); % Vetor de tempo em [s]


% -------------------------------------------------------------------------
% Plotando Dados Lidos

num_ch = 3; % Selecione a Quantidade de canais que deseja plotar
figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), x(ii,(t >= ti & t < tf)));
    hold on;
    plot(t(t >= ti & t < tf), mean(x(ii,:)).*ones(size(x(ii,(t >= ti & t < tf)))));
    legend('Sinal', ['Media = ' num2str(mean(x(ii,(t >= ti & t < tf))))] );
    grid on;
    title(['Coma - Canal ' num2str(ii)]) 
    ylabel('Tensão [V]');
    xlabel('Tempo [s]');
end


% -------------------------------------------------------------------------
% Parte A - Calculo de Valores 1

% Chama a função GetValores1
% Mandando como Argumento os valores de 
% X onde o tempo é maior ou igual o tempo inicial
% e menor do que o tempo final
valores1 = GetValores1(x(:,t >= ti & t < tf)); 

% -------------------------------------------------------------------------
% Parte B - Calculo de Potencia

% Chama a função GetPotencia com o mesmo argumento da parte A
potencias = GetPotencia(x(:,t >= ti & t < tf)); 

% -------------------------------------------------------------------------
% Plotando Dados Calculados

figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), valores1(ii,:));
    hold on;
    plot(t(t >= ti & t < tf), mean(valores1(ii,:)).*ones(size(valores1(ii,:))));
    legend('Sinal', ['Media = ' num2str(mean(valores1(ii,:)))] );
    text(tf-3,-40,['Potencia: ' num2str(potencias(ii))])
    grid on;
    title(['Valores 1 - Canal ' num2str(ii)]) 
    ylabel('Tensão [V]');
    xlabel('Tempo [s]');
end

% -------------------------------------------------------------------------
% Parte A - Calculo de Valores 1 para todo o Vetor com Janelamento

% Chama a função GetValores1 repetidas vezes
ti_old = ti;
tf_old = tf;
window_step = 0.25; % Passos de 0.25s
ti = ti;
tf = ti + window_step;
valores2 = GetValores1(x(:,t >= ti & t < tf)); 

while tf < tf_old
   ti = tf;
   tf = ti + window_step;
   valores2 = [valores2 GetValores1(x(:,t >= ti & t < tf))]; 
end

ti = ti_old;
tf = tf_old;

% -------------------------------------------------------------------------
% Plotando Dados Calculados por Media

figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(valores2(ii,:));
    hold on;
    plot(mean(valores2(ii,:)).*ones(size(valores2(ii,:))));
    legend('Sinal', ['Media = ' num2str(mean(valores2(ii,:)))] );
    text(tf-3,-40,['Potencia: ' num2str(potencias(ii))])
    grid on;
    title(['Valores 1 - Media Movel - Canal ' num2str(ii)]) 
    ylabel('Tensão [V]');
    xlabel('Tempo [s]');
end


% -------------------------------------------------------------------------
% Parte A - Calculo de Valores 1 com Filtro Passa Baixa

valores3 = zeros(size(x(:,t >= ti & t < tf)));

% Filtro Passa Baixa - Remover nivel DC
filtCutOff = 1; % Frequencia de corte em Hz
[b, a] = butter(1, (2*filtCutOff)/(1/samplePeriod), 'high'); % Butterworth

%Filtrando
for ii=1:20
    valores3(ii,:) = filtfilt(b, a, x(ii,t >= ti & t < tf));
end

% -------------------------------------------------------------------------
% Plotando Dados Calculados por Filtro Passa Baixa

figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), valores3(ii,:));
    hold on;
    plot(t(t >= ti & t < tf), mean(valores3(ii,:)).*ones(size(valores3(ii,:))));
    legend('Sinal', ['Media = ' num2str(mean(valores3(ii,:)))] );
    text(tf-3,-40,['Potencia: ' num2str(potencias(ii))])
    grid on;
    title(['Valores 1 - Passa Alta - Canal ' num2str(ii)]) 
    ylabel('Tensão [V]');
    xlabel('Tempo [s]');
end

