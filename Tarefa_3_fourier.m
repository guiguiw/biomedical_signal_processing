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


XF = zeros(10, Nf); 
XM = zeros(10, Nf);
XFF = zeros(10, Nf); %  vetor de fase da transformada de Fourier, dimensao Nf, radianos
XQ = zeros(10, Nf);
P = zeros(10, 1); % potencia espectral total do sinal, escalar
XN = zeros(10, Nf); %vetor de modulo normalizado da transformada, dimensao Nf, [W/Hz]

for ii = 1 : 10
  for k = 1 : Nf
      C = cos(2*pi*f(k).*tempo);
      S = sin(2*pi*f(k).*tempo);
      Cx = sinal(ii,:) .* C;
      Sx = sinal(ii,:) .* S;
      xrf = integral(Cx, Fs);         
      xif = integral(Sx, Fs);         
      XF(ii,k) = xrf - 1i*xif;           
      XM(ii,k) = sqrt(xrf^2 + xif^2);
      XFF(ii,k) = atan2d(xif,xrf);
      XQ(ii,k) = XM(k)^2;
  end
  % Normalizacao do espectro
  P(ii) = integralMod(XQ(ii,:), f);             
  XN(ii,:) = XM(ii,:) ./ sqrt(P(ii));                      
  soma = 0;
  for jj = 1 : length(XN)
    soma = soma + (XN(ii,jj) * f(jj));
  end
  fm = soma/sum(XN(ii,:));
end

