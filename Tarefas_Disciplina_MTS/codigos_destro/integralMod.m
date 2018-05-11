function [ integralTotal ] = integralMod( x, F )

%% Obten��o das vari�veis auxiliares para implementa��o do m�todo de
% integra��o num�rica (trap�zio simples)
    N = length(x);% N�mero de amostras do vetor x


%% Implementa��o do m�todo de integra��o
y = zeros(1,N); % Cria o vetor de sa�da
for k = 2 : N   % Itera��o do m�todo do trap�zio simples
y(k) = (F(k) - F(k-1))*(((x(k-1) + x(k))/2)) + y(k-1);
end

integralTotal = y(N);

end

