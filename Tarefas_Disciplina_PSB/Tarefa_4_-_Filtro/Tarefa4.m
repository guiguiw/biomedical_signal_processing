% ------------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering Lab
% ------------------------------------------------------------------------------
% Author: Italo Gustavo Sampaio Fernandes
% Contact: italogsfernandes@gmail.com
% Git: www.github.com/italogfernandes
% ------------------------------------------------------------------------------
% Decription:
% ------------------------------------------------------------------------------
% ------------------------------------------------------------------------------
% TAREFA 4
% 	Considere os dados .mat enviados em anexo, descritos detalhadamete na planilha Excel denominada
% 	“tab_coma_2.xls”. Tratam-se de trechos de EEG registrados em pacientes da vida real, internados na Unidade de
% 	Terapia Intensiva Adulta de nosso hospital de Clinicas. Este mesmo arquivo Excel descreve a situação clinica
% 	considerada, bem como dados dos pacientes. Considere os programas .m associados ao calculo da transformada de
% 	Fourier, utilizados para a execução da Tarefa 3.
% 	Cada grupo devera utilizar o conjunto de sinais especificados no arquivo “tab_coma_2.xls”, vejam a primeira
% 	coluna da esquerda deste arquivo. Notem que a ultima coluna especifica artefatos que perturbam os sinais, registrads
% 	a uma freqüência de amostragem fa = 250 Hz.
% 	OBJETIVO: Analisar e comparar as transformadas de Fourier dos sinais ligados a diferentes situações clinicas,
% 		identificando informações pertinentes aos ritmos neurológicos, e a contribuição dos artefatos no espectro dos sinais.
% 		PROCEDIMENTO
% 	Cada grupo deve selecionar uma linha da matriz de dados “valores”, correspondente a um certo canal, por favor
% 	anotem qual linha será considerada. A seguir, pelo menos cinco diferentes trechos do sinal selecionado deverão ser
% 	escolhidos, que serão denominados vetores de dados {X1,X2,X3,...,X5}. Cada vetor de dados deve conter um numero
% 	diferente de amostras, ou seja, o tempo total de cada trecho deve ser crescente, por exemplo tt = 1; 1.5; 2; 2.3; 3
% 	segundos;onde tt representa o tempo físico total do sinal. IMPORTANTISSIMO CADA GRUPO DEVE
% 	SELECIONAR OS DADOS {X1,X2,X3,...,X5} TODOS EM ÚNICO CANAL DE EEG, sendo que o canal
% 		selecionado por grupo deve FORÇOSAMENTE ser diferente um do outro.
% 	Em seguida, com ajuda dos programas .m supra-citados, serão calculados:
% 		( A) Os módulos normalizados das transformadas de Fourier {XN1,XN2,XN3,...,XN5}
% 		( B) As fases associadas aos módulos do item (A) {XFF1,XFF2,XFF3,...,XFF5}
% 		( C) As potencias espectrais {P1,P2,...,P5 }
% 		( D) As frequências medianas {fm1,fm2,...,fm5}
% 	Os resultados (A) – (D) deverão ser organizados e apresentados em slides com formato .ppt ou .pptx da seguinte
% 	forma.
% 	# Os módulos do item (A) deverão ser representados todos em função do vetor de frequências f, num mesmo gráfico,
% 		com as mesmas escalas tanto de frequência quanto de modulo normalizado. Para melhor visualizar a diferença entre os
% 		resultados, cada gráfico deve ser plotado com uma cor diferente.
% 	# As fases do item ( B) devem ser representadas em 5 gráficos diferentes, todos em função do vetor de frequências f,
% 		porem cada um deles deve sempre ser representado usando as mesmas escalas de fase  ́[radianos] e frequência [Hz].
% 		Colocar os d cinco gráficos lado a lado, de forma que todos os 5 caibam no mesmo slide. Escrever, ao alto de cada
% 		gráfico, o valor do tempo final associado.
% 	# As potencias de ( C) e frequências medianas de ( D) deverão ser representadas numa tabela conforme abaixo.
% 		Trecho do sinal e duracao
% 			Trecho 1 e duração xxxx seg
% 			Trecho 2 e duração xxxx seg
% 			...
% 			Trecho 5 e duração xxxx seg
% 		Valor de P [W]
% 			P1
% 			P2
% 			...
% 			P5
% 		Valor de fm [Hz]
% 			fm1
% 			fm2
% 			...
% 			fm5
% 	Ordenar esta tabela em função de valores crescentes ou decrescentes tempo final, conforme for mais adequado, com o
% 	objetivo de estabelecer comparações.Assim sendo, como produto final desta tarefa, cada grupo devera enviar por email um arquivo .ppt % %	ou .pptx contendo
% 	três slides, seguindo as orientações acima. Estes resultados serão cuidadosamente discutidos e comparados entre si nas
% 	aulas do 22/11 e 27/11.
% ------------------------------------------------------------------------------
addpath('../datasets','../codigos_destro')



%% Clearing the enviroment
clear; close all; clc;

%% Loading the data


%% Doing some stuff


%% Plotting
