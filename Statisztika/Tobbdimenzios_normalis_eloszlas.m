function [L, Y] = Tobbdimenzios_normalis_eloszlas(d, mu, sigma, n)
Y = zeros(d, n);
L = Cholesky(sigma);

for i=1:n
    X = Kozrefogas_modszere(d);
    Y(:, i) = mu + L*X';
end

end