function [ F ] = dft_coef(f)
%DFT_COEF Summary of this function goes here
    %% Calculo da DFT
    N = length(f);
    n = 0:(N-1);
    w = 2*pi*n/N;
    F = zeros(1, N);
    for k = 0 : (N-1)
       F(k+1) = (1/N) * sum(f .* exp(-1i.*w.*k));
    end
end

