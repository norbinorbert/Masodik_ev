function Lab12_3

X = [1:8];
N = [123, 141, 120, 135, 110, 131, 142, 109];

k = 8;
alpha = 0.03;

n = sum(N);
p_i0 = ones(1,8) * 1/8;

chi2_value = sum(((N - n .* (p_i0)) .^2) ./ (n .* (p_i0)))
chi2_quantile = chi2inv(1 - alpha, k - 1)

if chi2_value < chi2_quantile
    disp('Szabalyos a kocka');
else
    disp('Nem szabalyos a kocka');
end

end
