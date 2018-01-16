function [ valores1 ] = GetValores1(x)
%GETVALORES1 Retorna um vetor identico a X mas com media nula
%   Detailed explanation goes here
    [QntCh , Len] = size(x); % Tamanho dos dados
    valores1 = ones(QntCh , Len); % Reserva o Espaço de Memoria fora do laço 
    
    % Para cada canal, subtrai do seu valor o valor da media multiplicado
    % por um vetor de ones
    for ii=1:QntCh
        valores1(ii,:) = x(ii,:) - mean(x(ii,:)).*valores1(ii,:); 
    end
end

