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
% 
% Variáveis de saída:
%  - Ta = base de tempo [ms]
%  - fa = frequencia de amostragem [Hz]
%  - matriz = matriz de armazenamento dos sinais [10,5000]
%  - t = vetor de armazenamento do período(T) [1,10]

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
% Dados da matriz
% comprimento de amostras
N=5000;
% vetores de dados
Q=10;

% Criação de uma matriz unitária com dimensão [N,Q], ou seja, [10,5000]
matriz = ones(Q,N);

% Vetor de armazenamento do tempo de cada amostra
t = zeros(1,Q);

%%-----------------------------PARTE 1---------------------------------%%

% Número de tentativas feitas pelo usuário
tentativa=1;

% Tempo máximo [ms]
tmax=0;

% Variáveis auxiliares
cont=1; 
subcont=1;
X=zeros(10,5000);

% Entrada de dados pelo usuário para criação dos vetores
for i=1:10 % quantidade de vetores que serão criados  
tentativa = 1;
A = input('Digite a amplitude: '); % amplitude qualquer [ms]
fo= input('Digite uma frequencia: '); % frequência qualquer [Hz]
tmax=3*(1/fo);

while tmax<=3*(1/fo) % tmax deve ser maior que 3*(1/fo)
    if(tentativa>=2)
        disp('Erro, digite um valor maior');
    end
    tentativa=1+tentativa;
    tmax = input('Digite o tempo maximo: ');
end

fa=4*fo; % frenquência de amostragem

T=1/fa; % Perído 
% Criação de um vetor com o número de pontos já definido 
t=linspace(0,tmax,5000);
t=t(1:5000);

X(i,:) = 2*pi*fo.*t;
tint(i,:)=t;
amp(i,:)=A;
Fo(i,:)=fo;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIM DA PARTE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%--------------------------------PARTE 2--------------------------------%%
syms Ti
for i=1:10

% Salva em x a equação seno da integral indefinida
x=amp(i,1) * sin(2*pi*Fo(i,1)*Ti);

% Salva em Xint a equação da integral daquela função
Xint=int(x);

disp('Integral indefinida:')
Xint=int(x)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIM DA PARTE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%

