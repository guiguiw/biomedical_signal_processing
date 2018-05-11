

%% Initial
load action_potencials.mat
Fs = 1 / (t_out(2) - t_out(1));
N = length(t_out);

%% -----------Fourier utilizando as funcoes do matlab---------------------------------%%
inc_f = Fs/N;   %Calculo do incremento no domínio das frequências
f = inc_f:inc_f:inc_f*(N/2);                     %Determinando o vetor de frequências (metade do tamanho do vetor de tempos)
lgt_y = N;
                               
%% Execução da FFT
y = V_out; 
Y = fft(y);                            
Y_abs = abs(Y(1:lgt_y/2));       %Extração do vetor de anplitudes pela frequência.
Y_ang = rad2deg(angle(Y(1:lgt_y/2))); %Extração do vetor de Ângulos pela frequência. A função angle calcula o ângulo no índice complexo em radianos e a função radtodeg converte esse valor em graus
                     
%% Ploting
figure;
subplot(2, 1, 1);
plot(t_out, V_out);
title('Time series')
xlabel('Time (sec)');
ylabel('Amplitude (V)');

subplot(2,1,2);
plot(f,Y_abs,'r');
title('Amplitude Fourier Spectrum')
xlabel('Frequency (Hz)');
ylabel('Amplitude (V)');
xlim( [0, 1000]);
