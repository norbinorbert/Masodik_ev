function Lab7_1
n = 10000;
lambda = 2;
X = ExactInversion('exp', lambda, n);
fprintf('Exponencialis(%f)\n', lambda);
fprintf('elmeleti varhato ertek: %f\n', 1/lambda);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', 1/lambda^2);
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

mu = 10;
sigma = 2;
X = Kozrefogas_modszere_altalanos(n, mu, sigma);
fprintf('Normalis(%f, %f)\n', mu, sigma);
fprintf('elmeleti varhato ertek: %f\n', mu);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', sigma^2);
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

a = -1;
b = 9;
X = URealRNG(0, 4, a, b, n);
fprintf('Egyenletes(%f, %f)\n', a, b);
fprintf('elmeleti varhato ertek: %f\n', (a+b)/2);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', (b-a)^2/12);
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

n1 = 16;
p = 1/2;
Y = zeros(2, n1);
for i=1:n1+1
    k = i-1;
    Y(1, i) = k;
    Y(2, i) = nchoosek(n1, k) * p^k *(1-p)^(n1-k);
end
X = InversionBySequentialSearch(Y, 2, n);
fprintf('Binomialis(%f %f)\n', n1, p);
fprintf('elmeleti varhato ertek: %f\n', n1*p);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', n1*p*(1-p));
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

N = 32;
M = 20;
n1 = 12;
kezdo = max(0, n1-N+M);
vegso = min(n1,M);
Y = zeros(2, vegso-kezdo+1);
index = 1;
for i=kezdo:vegso
    Y(1, index) = i;
    Y(2, index) = nchoosek(M, i) * nchoosek(N-M,n1-i) / nchoosek(N, n1);
    index = index+1;
end
X = InversionBySequentialSearch(Y, 2, n);
fprintf('Hipergeometrikus(%f, %f, %f)\n', N, M, n1);
fprintf('elmeleti varhato ertek: %f\n', n1*M/N);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', n1*(M/N)*((N-M)/N)*((N-n1)/(N-1)));
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

p = 1/4;
lambda = -log(1-p);
X = ExactInversion('exp', lambda, n);
X = ceil(X);
fprintf('Geometriai(%f)\n', p);
fprintf('elmeleti varhato ertek: %f\n', 1/p);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', (1-p)/p^2);
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

a = 15;
X = ExactInversion('haromszogu', a, n);
fprintf('Haromszogu(%f)\n', a);
fprintf('elmeleti varhato ertek: %f\n', a/3);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', ((a^2)/18));
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

a = 6;
b = 2;
F = @(x) ContinuousCDF(x, 'gamma', [a, b]);
X = Hur_modszer(F, n, 0.001, 0.01, 35);
fprintf('Gamma(%f, %f)\n', a, b);
fprintf('elmeleti varhato ertek: %f\n', a*b);
fprintf('gyakorlati varhato ertek: %f\n', mean(X));
fprintf('elmeleti szorasnegyzet: %f\n', a*b^2);
fprintf('gyakorlati szorasnegyzet: %f\n\n', var(X));

end