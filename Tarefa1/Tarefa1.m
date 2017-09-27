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
ti = 0; % Definicao do tempo de inicio
tf = 10; % Definicao do tempo final
clear coma;

[Q, N] = size(x);
samplePeriod = 1/Fs; % Periodo de Amostragem
t = samplePeriod*(0:(N-1)); % Vetor de tempo em [s]


% -------------------------------------------------------------------------
% Plotando Dados Lidos

num_ch = 2; % Selecione a Quantidade de canais que deseja plotar
figure();
for ii=1:num_ch
    subplot(num_ch,1,ii);
    plot(t(t >= ti & t < tf), x(ii,:));
    hold on;
    plot(t(t >= ti & t < tf), mean(x(ii,:)).*ones(size(x(ii,:))));
    legend('Sinal', ['Media = ' num2str(mean(x(ii,:)))] );
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
valores1 = GetValores1(x(:,t >= ti & t < tf,:)); 

% -------------------------------------------------------------------------
% Parte B - Calculo de Potencia

% Chama a função GetPotencia com o mesmo argumento da parte A
potencias = GetPotencia(x(:,t >= ti & t < tf,:)); 

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

