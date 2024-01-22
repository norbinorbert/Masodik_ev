%Boda Norbert, bnim2219
function feladat2
X = [1:13];
N = [3555, 2101, 1100, 651, 343, 221, 120, 79, 56, 23, 11, 13, 5];

Tomb = zeros(1, sum(N));
index = 1;
for i=1:length(N)
    for j=1:N(i)
        Tomb(index)= X(i);
        index = index + 1;
    end
end
hist(Tomb, 13);

k = 13;
alpha = 0.01;

n = sum(N);
p = n / sum(N.*X);
p_i0 = DiscretePDF(X(1:12), 'geometric', p);
p_i0(13) = 1 - sum(p_i0(1:12));
l = 1;

chi2_value = sum(((N - n .* (p_i0)) .^2) ./ (n .* (p_i0)))
chi2_quantile = chi2inv(1 - alpha, k - l - 1)

if chi2_value < chi2_quantile
    disp('Geometriai eloszlast kovet');
    disp(p);
else
    disp('Nem kovet geometriai eloszlast');
end

end
