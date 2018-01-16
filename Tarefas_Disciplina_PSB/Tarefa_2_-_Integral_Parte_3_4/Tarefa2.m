%--------------------------------------------------------------------------
% TAREFA 2
% Considere os seguintes sinais artificiais, supondo Ta representativo do tempo de
% amostragem [ms] e fa, a frequência de amostragem [Hz]. Todos os sinais tem duração de 0 a
% 10 ms.
% Sinal 1 (Grupo 1):
% 	Onde C é uma constante qualquer real que pode variar de 0.001 até 100, sendo considerado
% 	um parâmetro característico do sinal. Suponha dois casos: no primeiro caso, 0.001 <= C <=
% 	0.1; no segundo caso, 10 < C < 100. Utilizar frequência de amostragem fa = 100 kHz.
% Sinal 2 (Grupo 2): x2(t) = B. exp (-α.t), onde B é uma amplitude qualquer [mV]; α é a constante
% 	de decaimento, podendo variar entre os valores reais [0,10]. Utilizar fa = 10 kHz. As grandezas
% 	B, α e tmax são estipuladas pelo usuário, sendo considerados parâmetros do sinal. Sugestão:
% 	utilizar o comando “exp” do Matlab.
% Sinal 3 (Grupo 3): x3(t) = β – β t, onde β descreve o decaimento da reta. Utilizar fa = 1000 Hz.
% Sinal 4 (Grupo 4): x4(t) = A. sin(2.π.fo.t), onde A é uma amplitude qualquer [mV], fo é uma
% 	frequência qualquer [Hz], e o tempo analógico varia de t = 0 ms até o tempo máximo tmax [ms],
% 	onde tmax deve ser maior que o valor 3x(1/fo). Utilizar fa = 4 x fo. As grandezas A, fo e tmax
% 	são estipuladas pelo usuário, sendo considerados parâmetros do sinal. Sugestão: utilizar o
% 	comando “sin” do Matlab.
% Parte 1
% 	Gerar um programa (arquivo .m), em cuja primeira linha são estipuladas suas entradas,
% 	as quais consistem nos parâmetros do sinal (estabelecidos pelo usuário) e na frequência de
% 	amostragem, esta última fixada conforme as recomendações feitas acima para cada sinal. Em
% 	seguida, o programa deve gerar um vetor de tempos analógicos adequado, representado pela
% 	variável t, para finalmente gerar o vetor X, que armazena as amostras do sinal. Grupo1 por
% 	favor considere os dois casos separadamente.
% 	Com os programas da parte 1, cada grupo deve gerar pelo menos 10 vetores de dados
% 	{X1, X2,...,X10}. Cada vetor deve ter um comprimento de 5000 amostras, e deve-se usar
% 	diferentes parâmetros do sinal para a geração de cada um dos dez vetores. ANOTAR
% 	CUIDADOSAMENTE, para cada um dos 10 vetores, os parâmetros considerados, pois estes
% 	serão necessários para a sequencia de passos desta tarefa.
% Parte 2
% 	Calcular teoricamente a fórmula do sinal obtido após a integração indefinida dos sinais
% 	estabelecidos no inicio do enunciado desta Tarefa. Obtenha uma expressão analítica, que deve
% 	ser implementada sob forma de programa .m. Grupo1 por favor considere os dois casos
% 	separadamente.
% Parte 3
% 	Com a ajuda dos programas “integral.m” e “integralMod.m”, discutidos na aula do
% 	09/10/17, realizar a integração numérica dos sinais gerados na Parte 1. Considere os10 sinais
% 	diferentes, gerados ao final da Parte 1. Comparar os resultados de integração obtidos com
% 	esses programas, com a curva teórica estipulada na Parte 2. Apresente um arquivo .doc que
% 	contenha os resultados, a serem apresentados em gráficos de mesmas escalas, onde as
% 	imagens das curvas obtidas na Parte 3 são confrontadas com as imagens das curvas obtidas
% 	ao final da parte 2.
% Parte 4
% 	Cada grupo deverá propor um programa próprio de integração, seguindo uma
% 	abordagem própria, diferente NECESSARIAMENTE da abordagem seguida por todos os
% 	demais grupos de estudantes, E TAMBEM DIFERENTE DA ABORDAGEM ADOTADA PELO
% 	PROFESSOR , esta última discutida na aula do 09/10/17. Testar este programa, fazendo uso
% 	dos sinais sintéticos acima. Compare o desempenho de seu próprio programa ao desempenho
% 	do programa fornecido pelo Prof Destro. Os resultados dessa parte deverão ser resumidos num
% 	relatório .doc.
% Deverão ser enviados por email os programa .m gerados nas partes 1-4, devidamente
% documentados (separação das diversas partes, listas de variáveis de entrada e de saída),
% além dos dos gráficos/tabela solicitados. Estes mesmos programas, gráficos e tabelas
% deverão ser apresentados nsa aulas de discussão desta tarefa.
%--------------------------------------------------------------------------
addpath('../datasets','../codigos_destro')
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
