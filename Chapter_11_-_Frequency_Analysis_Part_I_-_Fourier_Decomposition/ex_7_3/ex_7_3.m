% EXERCISE 7.3
%     If N represents sample size, what can
%     you observe about the benefits of scaling as
%     N grows? Where does the efficiency of the
%     FFT algorithm benefit most, for large N or
%     small N?

figure
hold on
N = 1:10 * 100;
plot(N, N.^ 2, 'b')
plot(N, N.*log(N), 'r')