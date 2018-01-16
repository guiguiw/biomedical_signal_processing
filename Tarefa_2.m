close all;
screensize = get( 0, 'Screensize' );
%%-----------------------------PARTE 3---------------------------------%%
%%Considerando o tempo total de todo sinal como 10ms
sinais = zeros(10,5000);
tempo_total = 10E-3;
tempo = linspace(0,10E-3,5000);
Amplitudes = 1:10;
frequencias = 150:10:240;
Fs = 1 / (tempo(2) - tempo(1)); %frequencia de aquisicao
% Gerando sinais:
for ii=1:10
   sinais(ii,:) = Amplitudes(ii)*sin(2*pi*frequencias(ii)*tempo); 
end
% Plotando os sinais
fig = figure;
set(fig,'Position',screensize)
for ii=1:10
    subplot(5,2,ii);
    plot(tempo,sinais(ii,:));
    title(['Sinal num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
end

disp('Tempo para executar usando Integral do Prof. Dr. Destro: ');
tic
integrais = zeros(size(sinais)); %matriz p/ salvar as integrais
integrais_totais_destro = zeros(10,1);
for ii=1:10
    [ integrais_totais_destro(ii),integrais(ii,:)] = integral(sinais(ii,:),Fs);
end
toc

screensizeright = [(screensize(3)/2) screensize(2) screensize(3)/2 screensize(4)];
% Plotando os sinais com suas integrais
fig = figure;
set(fig,'Position',screensizeright)
for ii=1:10
    subplot(5,2,ii);
    plot(tempo,sinais(ii,:));
    hold on;
    plot(tempo, integrais(ii,:),'r');
    title(['Sinal num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
    hold off;
    legend('sinal',[ 'integral total = ', num2str(integrais_totais_destro(ii))])
end

disp(' ');
disp('Tempo para executar usando Trapz: ');
tic
integrais_totais_trapz = zeros(size(integrais_totais_destro));
for ii=1:10
    integrais_totais_trapz(ii,1) = trapz(sinais(ii,:))*1/Fs;
end
toc

screensizeleft = [screensize(1) screensize(2) screensize(3)/2 screensize(4)];
% Plotando os sinais com suas integrais calculadas por trapz
fig = figure;
set(fig,'Position',screensizeleft)
for ii=1:10
    subplot(5,2,ii);
    plot(tempo,sinais(ii,:));
    title(['Sinal num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
    legend([ 'trapz = ', num2str(integrais_totais_trapz(ii,1) )])
end
%%------------------------------PARTE 4----------------------------------%%
% Calculo da integral pela nossa formula
% Sera usada a soma de Riemann
% Ela eh definidada pelo somatorio com i de 0 ate n-1
% da seguinte expressao: f(ti)*(x(i+1) - x(i))
% Considerando que x(i+1) - x(i) eh fixada pela nossa frequencia de 
% aquisicao, portanto eh dada como o Periodo de aquisicao
% (x(i+1) - x(i)) = 1/Fs
disp(' ');
disp('Tempo para executar usando Riemann: ');
tic
integrais_totais_riemann = sum(sinais .* (1/Fs), 2);
toc
disp(' ');
% Plotando os sinais com suas integrais calculadas por riemann
screensizeright = [(screensize(3)/2) screensize(2) screensize(3)/2 screensize(4)];
fig = figure;
set(fig,'Position',screensizeright)
for ii=1:10
    integrais_totais_trapz(ii,1) = trapz(sinais(ii,:))*1/Fs;
    subplot(5,2,ii);
    plot(tempo,sinais(ii,:));
    title(['Sinal num ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
    legend([ 'riemann = ', num2str(integrais_totais_riemann(ii,1) )])
end

% Mostrando os sinais com suas integrais calculadas
% por: destro, trapeziodal e por riemann
for ii=1:10
    disp('********************************************');
    disp(['Sinal num  ' num2str(ii) ' f = ' num2str(frequencias(ii)) ' Hz - A = ' num2str(Amplitudes(ii))])
    disp(['Destro = ', num2str(integrais_totais_destro(ii,1))]);
    disp(['Trapzoidal = ', num2str(integrais_totais_trapz(ii,1))]);
    disp(['Riemann = ', num2str(integrais_totais_riemann(ii,1))]);
end
