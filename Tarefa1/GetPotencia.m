function [ potencia ] = GetPotencia( valores )
%GETPOTENCIA Retorna a potencia media de cada canal em valores
%   Detailed explanation goes here
    [~ , Len] = size(valores); % Tamanho dos Dados
    potencia = (1./Len) .* sum(valores.^2,2);
end

