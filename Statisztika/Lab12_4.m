function Lab12_4

X = [0:7];
N = [1620, 1947, 1262, 504, 138, 24, 4, 1];

k = 8;
alpha = 0.01;


n = sum(N);
lambda = sum(N.*X) / n;
p_i0 = DiscretePDF(X(1:7), 'poisson', lambda);
p_i0(8) = 1 - sum(p_i0(1:7));
l = 1;

chi2_value = sum(((N - n .* (p_i0)) .^2) ./ (n .* (p_i0)))
chi2_quantile = chi2inv(1 - alpha, k - l - 1)

if chi2_value < chi2_quantile
    disp('Poisson eloszlast kovet');
    disp(lambda);
else
    disp('Nem kovet Poisson eloszlast');
end

end
