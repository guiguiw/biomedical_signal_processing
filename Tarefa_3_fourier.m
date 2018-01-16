
%--------------------------------------------------------------------------

% FEDERAL UNIVERSITY OF UBERLANDIA

% Faculty of Electrical Engineering

% Biomedical Engineering

%--------------------------------------------------------------------------

% Author(s): Ana Carolina Torres, Giovanna Cavalcante Barndao lima,

% Henrique Andrade Barbosa, Italo Gustavo Sampaio Fernandes,Paulo

% Eduardo Alves.

%--------------------------------------------------------------------------

% Decription: 

% Variáveis de entrada:

%  - A = Amplitude do sinal [ms]

%  - fo = frequencia qualquer [Hz]

%  - tmax = tempo máximo [ms]

%

% Variáveis intermediárias:

%  - Q = número de linhas da matriz (vetores de dados)

%  - N = número de colunas da matriz (comprimento de amostras)

%  - T = Perído utilizado para calcular o Ta (base de tempo)[ms]

%  - cont, subcont,contador, subcontador, termoanterior, termoposterior, tentativa = variável auxiliar,  usada como contador

%  - x = asen do ângulo da função seno utilizada 

% FUNCOES NECESSARIAS PARA QUE O PROGRAMA SEJA EXECUTADO: integral.m,

% integralMod.m

%

% Variaveis de saida

% t     vetor de base de tempo, mesma dimensao de X

% f     vetor de base de frequencias, dimensao Nf

% XFF   vetor de fase da transformada de Fourier, dimensao Nf, radianos

% P     potencia espectral total do sinal, escalar

% XN    vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz]

% dm    frequencia mediana do sinal [Hz]

%  - Ta = base de tempo [ms]

%  - fa = frequencia de amostragem [Hz]

%  - matriz = matriz de armazenamento dos sinais [10,5000]

%  - t = vetor de armazenamento do período(T) [1,10]

 

 

%--------------------------------------------------------------------------

close all;

screensize = get( 0, 'Screensize' );

%%----------------------------Gerando---------------------------------%%

%%Considerando o tempo total de todo sinais como 10ms

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

    title(['sinais num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])

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

P = zeros(10, 1); % potencia espectral total do sinais, escalar

fm = zeros(10, 1); %frequências medianas

  

XF = zeros(10, Nf); %vetor da transformada em numero complexo

XM = zeros(10, Nf); %Vetor dos modulos da transformada raiz(real^2 + imaginario^2)

XQ = zeros(10, Nf); %XM elevado ao quadrado utilizado pela formula da potencia

 

for ii = 1 : 10

  for k = 1 : Nf %Para cada harmonica

      C = cos(2*pi*f(k).*tempo); %Equacao da parte do cos da transformada de fourier

      S = sin(2*pi*f(k).*tempo); %Equacao da parte do seno da tranformada de fourier

      Cx = sinais(ii,:) .* C; %sinais vezes a parte do cosseno

      Sx = sinais(ii,:) .* S; %sinais vezes a parte do seno

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

                               

fig = figure;

set(fig,'Position',screensize)

subplot(2,2,1:2);

hold on;

for ii = 1:10

    plot(tempo,sinais(ii,:));

end

legend(['Sinal ' num2str(1) ' f = ' num2str(frequencias(1)) ' Hz - A = ' num2str(Amplitudes(1))],...

    ['Sinal ' num2str(2) ' f = ' num2str(frequencias(2)) ' Hz - A = ' num2str(Amplitudes(2))],...

    ['Sinal ' num2str(3) ' f = ' num2str(frequencias(3)) ' Hz - A = ' num2str(Amplitudes(3))],...

    ['Sinal ' num2str(4) ' f = ' num2str(frequencias(4)) ' Hz - A = ' num2str(Amplitudes(4))],...

    ['Sinal ' num2str(5) ' f = ' num2str(frequencias(5)) ' Hz - A = ' num2str(Amplitudes(5))],...

    ['Sinal ' num2str(6) ' f = ' num2str(frequencias(6)) ' Hz - A = ' num2str(Amplitudes(6))],...

    ['Sinal ' num2str(7) ' f = ' num2str(frequencias(7)) ' Hz - A = ' num2str(Amplitudes(7))],...

    ['Sinal ' num2str(8) ' f = ' num2str(frequencias(8)) ' Hz - A = ' num2str(Amplitudes(8))],...

    ['Sinal ' num2str(9) ' f = ' num2str(frequencias(9)) ' Hz - A = ' num2str(Amplitudes(9))],...

    ['Sinal ' num2str(10) ' f = ' num2str(frequencias(10)) ' Hz - A = ' num2str(Amplitudes(10))]);    

title('Sinais gerados');

%... Completar

subplot(2,2,3);

hold on;

 

for ii = 1:10

    plot(f,XM(ii,:));

end

legend(['Sinal ' num2str(1) ' P = ' num2str(P(1)) ' W - fm = ' num2str(fm(1))],...

    ['Sinal ' num2str(2) ' P = ' num2str(P(2)) ' W - fm = ' num2str(fm(2))],...

    ['Sinal ' num2str(3) ' P = ' num2str(P(3)) ' W - fm = ' num2str(fm(3))],...

    ['Sinal ' num2str(4) ' P = ' num2str(P(4)) ' W - fm = ' num2str(fm(4))],...

    ['Sinal ' num2str(5) ' P = ' num2str(P(5)) ' W - fm = ' num2str(fm(5))],...

    ['Sinal ' num2str(6) ' P = ' num2str(P(6)) ' W - fm = ' num2str(fm(6))],...

    ['Sinal ' num2str(7) ' P = ' num2str(P(7)) ' W - fm = ' num2str(fm(7))],...

    ['Sinal ' num2str(8) ' P = ' num2str(P(8)) ' W - fm = ' num2str(fm(8))],...

    ['Sinal ' num2str(9) ' P = ' num2str(P(9)) ' W - fm = ' num2str(fm(9))],...

    ['Sinal ' num2str(10) ' P = ' num2str(P(10)) ' W - fm = ' num2str(fm(10))]);    

title('Fourier - Modulos');

ylabel('Power');

xlabel('Frequency (Hz)');

axis([0 500 0 0.05]);

%... Completar

subplot(2,2,4);

 

hold on;

 

for ii = 1:10

    plot(f,XFF(ii,:));

end

title('Fourier - Fases');

%...                           

                          

    

%%------------Fourier utilizando as funcoes do matlab---------------------------------%%

inc_f = Fs/N;   %Calculo do incremento no domínio das frequências

f = inc_f:inc_f:inc_f*(N/2);                     %Determinando o vetor de frequências (metade do tamanho do vetor de tempos)

lgt_y = N;

                               

%%

%Execução da FFT

y = sinais(1,:); %somente do primeiro sinais

Y = fft(y);                             

Y_abs = abs(Y(1:lgt_y/2));                                     %Extração do vetor de anplitudes pela frequência.

Y_ang = radtodeg(angle(Y(1:lgt_y/2)));                         %Extração do vetor de Ângulos pela frequência. A função angle calcula o ângulo no índice complexo em radianos e a função radtodeg converte esse valor em graus

                     

%Ploting

figure;

subplot(2,2,1);

plot(tempo,y);

title('Time series')

xlabel('Time (sec)');

ylabel('Amplitude (V)');

 

subplot(2,2,2);

plot(Y);

title('Fourier Complex Series')

xlabel('Real axis');

ylabel('Imaginary axis');

 

subplot(2,2,3);

plot(f,Y_abs,'r');

title('Amplitude Fourier Spectrum')

xlabel('Frequency (Hz)');

ylabel('Amplitude (V)');

 

subplot(2,2,4);

plot(f,Y_ang,'m');

title('Phase Fourier Spectrum')

xlabel('Frequency (Hz)');

ylabel('Angle (deg)');



