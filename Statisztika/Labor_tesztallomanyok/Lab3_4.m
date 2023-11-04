function Lab3_4
figure;

lambda = 8;
r = 10000;
X = Poisson_eloszlas(lambda, r);
subplot(1, 2, 1);
hist(X);
title('Poisson');

%%%%%%%%%%%%%%%%%%%

p = 2/3;
n = 10000;
lambda = -log(1-p);
X = ExactInversion('exp', lambda, n);
X = ceil(X);

subplot(1, 2, 2);
hist(X);
title('Geo');

end