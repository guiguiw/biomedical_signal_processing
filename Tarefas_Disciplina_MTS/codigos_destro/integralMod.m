function [ integralTotal ] = integralMod( x, F )

%% Obtenção das variáveis auxiliares para implementação do método de
% integração numérica (trapézio simples)
    N = length(x);% Número de amostras do vetor x


%% Implementação do método de integração
y = zeros(1,N); % Cria o vetor de saída
for k = 2 : N   % Iteração do método do trapézio simples
y(k) = (F(k) - F(k-1))*(((x(k-1) + x(k))/2)) + y(k-1);
end

integralTotal = y(N);

end

