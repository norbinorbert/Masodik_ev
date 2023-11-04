function Lab3_1
%1-es, mintavetelezesek %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(2, 3, 1);
distribution_type = 'exp';
parameters = [6, 3];
n = 10000;
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('exponencialis');

subplot(2, 3, 2);
distribution_type = 'Cauchy';
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('Cauchy');

subplot(2, 3, 3);
distribution_type = 'Rayleigh';
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('Rayleigh');

subplot(2, 3, 4);
distribution_type = 'haromszogu';
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('haromszogu');

subplot(2, 3, 5);
distribution_type = 'Rayleigh-veg';
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('Rayleigh-veg');

subplot(2, 3, 6);
distribution_type = 'Pareto';
X = ExactInversion(distribution_type, parameters, n);
hist(X);
title('Pareto');

%1-es, megadott f fuggveny %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
subplot(1, 2, 1);
x = [0:0.00025:1];
f = ContinuousPDF(x, 'Lab3_1', []);
F = ContinuousCDF(x, 'Lab3_1', []);
plot(x, f, 'g', x, F, 'r');
title('pdf(zold) es cdf(piros)');

subplot(1, 2, 2);
X = ExactInversion('Lab3_1', [], 10000);
hist(X);
title('histogram');

end