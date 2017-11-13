close all;
screensize = get( 0, 'Screensize' );
%%----------------------------Gerando---------------------------------%%
%%Considerando o tempo total de todo sinal como 10ms
N = 5000;
sinais = zeros(10,N);
tempo_total = 10E-3;
tempo = linspace(0,10E-3,N);
Amplitudes = 1:10;
frequencias = 150:10:240;
Fs = 1 / (tempo(2) - tempo(1)); %frequencia de aquisicao
% Gerando sinais:
for ii=1:10
   sinais(ii,:) = Amplitudes(ii)*sin(2*pi*frequencias(ii)*tempo); 
end
%%--------Plotando os sinais--------
fig = figure;
set(fig,'Position',screensize)
for ii=1:10
    subplot(5,2,ii);
    plot(tempo,sinais(ii,:));
    title(['Sinal num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
end

%%------------Fourier pelo cod do Prof. Dr. Destro---------------------------------%%

% Vetores comuns a todos os 10 sinais
f1_har = Fs/N;
f = 0:f1_har:Fs/2; %vetor de base de frequencias, dimensao Nf
Nf = length(f);

%Obter: 
% XN -> modulo da transformada normalizada  {XN1, XN2,...,XN10}
% XFF -> fase da transformada {XFF1, XFF2,...,XFF10
% sinais ->  sinais {X1, X2,...,X10}
% P -> potências  {P1, P2,...,P10} 
% fm -> frequências medianas {fm1, fm2,...,fm10}.

%Alocação da memoria
XN = zeros(10, Nf); %vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz]
XFF = zeros(10, Nf); %  vetor de fase da transformada de Fourier, dimensao Nf, radianos
P = zeros(10, 1); % potencia espectral total do sinal, escalar
fm = zeros(10, 1); %frequências medianas
  
XF = zeros(10, Nf); %vetor da transformada em numero complexo
XM = zeros(10, Nf); %Vetor dos modulos da transformada raiz(real^2 + imaginario^2)
XQ = zeros(10, Nf); %XM elevado ao quadrado utilizado pela formula da potencia

for ii = 1 : 10
  for k = 1 : Nf %Para cada harmonica
      C = cos(2*pi*f(k).*tempo); %Equacao da parte do cos da transformada de fourier
      S = sin(2*pi*f(k).*tempo); %Equacao da parte do seno da tranformada de fourier
      Cx = sinal(ii,:) .* C; %sinal vezes a parte do cosseno
      Sx = sinal(ii,:) .* S; %sinal vezes a parte do seno
      xrf = integral(Cx, Fs); %o coeficiente da parte real ven do cosseno
      xif = integral(Sx, Fs); %e o coeficiente da parte imaginaria vem do seno
      XF(ii,k) = xrf - 1i*xif; %juntado imaginario e real num numero complexo
      XM(ii,k) = sqrt(xrf^2 + xif^2); %Modulo do numero complexo
      XFF(ii,k) = atan2d(xif,xrf); %Fase do numero complexo
      XQ(ii,k) = XM(k)^2; %Modulo ao quadrado
  end
  % Normalizacao do espectro
  P(ii) = integralMod(XQ(ii,:), f); %Obtem a potencia utilizando o modulo ao quadrado, ver tarefas anteriores
  XN(ii,:) = XM(ii,:) ./ sqrt(P(ii)); %Normaliza XM pela potencia                      
  soma = 0;
  for jj = 1 : length(XN)
    soma = soma + (XN(ii,jj) * f(jj)); %Somatorio para calculo da frequencia mediana
  end
  fm(ii) = soma/sum(XN(ii,:)); %Frequencia mediana
end
%%------Plotando os sinais:------%%
%3. Plotar, num mesmo gráfico e utilizando escalas adequadas, os pares de vetores de dados (t,Xi), (f,XNi); (f,XFFi),]
%   onde i = 1,...,10; considerando sempre o mesmo vetor f. Para cada valor de i, fazer um gráfico de cores diferentes.
%   Ou seja, devem ser geradas 3 figuras. Na primeira figura, todos os 10 sinais no tempo serão mostrados com a mesma
%   escala de tempo e amplitude, enquanto que na segunda figura todos os módulos das 10 transformadas serão apresentados
%   com a mesma escala de frequência e potencia. O mesmo vale para a terceira figura, onde todos os 10 graficos de fase 
%   da transformada serão apresentados com a mesma escala de frequência e fase. Apresentar também uma tabela, onde os
%   valores escalares de potências {P1, P2,...,P10} serão mostrados numa coluna, os valores escalares de frequências
%   medianas {fm1, fm2,...,fm10} serão mostrados na segunda coluna, e os valores dos parâmetros característicos dos
%   sinais Xi serão mostrados na terceira coluna. 
 
% https://www.mathworks.com/help/matlab/ref/subplot.html?s_tid=doc_ta
% https://www.mathworks.com/help/matlab/ref/hold.html?searchHighlight=hold&s_tid=doc_srchtitle
% https://www.mathworks.com/help/matlab/ref/figure.html
% https://www.mathworks.com/help/matlab/ref/plot.html?searchHighlight=plot&s_tid=doc_srchtitle


%---------Sugestão:
%https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcS50Fte6YKvV8td3U5NbDWXUFRsqfuZVpOuqUdK8bGATf4xyd                               
%http://matlab.izmiran.ru/help/techdoc/ref/subplota.gif
                               
figure();
subplot(2,2,1:2);
title('Sinais gerados');
plot(t,sinal(1,:));
hold on;
plot(t,sinal(2,:));
%... Completar
subplot(2,2,3);
title('Fourier - Modulos');
plot(f,XM(1,:));
hold on;
plot(t,XM(2,:));
%... Completar
subplot(2,2,4);
title('Fourier - Fases');
plot(f,XFF(1,:));
hold on;
plot(t,XFF(2,:));
%...                           
                          
    
%%------------Fourier utilizando as funcoes do matlab---------------------------------%%
inc_f = Fs/N;   %Calculo do incremento no domínio das frequências
f = inc_f:inc_f:inc_f*(lgt_y/2);                     %Determinando o vetor de frequências (metade do tamanho do vetor de tempos)
lgt_y = N;
                               
%%
%Execução da FFT
y = sinal(1,:); %somente do primeiro sinal
Y = fft(y);                             
Y_abs = abs(Y(1:lgt_y/2));                                     %Extração do vetor de anplitudes pela frequência.
Y_ang = radtodeg(angle(Y(1:lgt_y/2)));                         %Extração do vetor de Ângulos pela frequência. A função angle calcula o ângulo no índice complexo em radianos e a função radtodeg converte esse valor em graus
                     
%Ploting
figure;
subplot(2,2,1);
plot(t,y); hold on; plot(t,y_filt,'r');
title('Time series')
xlabel('Time (sec)');
ylabel('Amplitude (V)');

subplot(2,2,2);
plot(Y);hold on; plot(YF,'r');
title('Fourier Complex Series')
xlabel('Real axis');
ylabel('Imaginary axis');

subplot(2,2,3);
plot(f,Y_abs,'r'); hold on; plot(f, YF_abs,'g');
title('Amplitude Fourier Spectrum')
xlabel('Frequency (Hz)');
ylabel('Amplitude (V)');

subplot(2,2,4);
plot(f,Y_ang,'m');hold on; plot(f, YF_ang,'c');
title('Phase Fourier Spectrum')
xlabel('Frequency (Hz)');
ylabel('Angle (deg)');

