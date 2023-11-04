function Lab3_2
mu = 7;
sigma = 3/2;
F = @(x) ContinuousCDF(x, 'normal', [mu, sigma]);

%felezo modszer
n = 7000;
delta = 0.01;
a = 3;
b = 11;
X = Felezo_modszer(F, n, delta, a, b);
figure;
subplot(1, 2, 1);
hist(X);
title('2. feladat, felezo modszer');

% hur modszer
X = Hur_modszer(F, n, delta, a, b);
subplot(1, 2, 2);
hist(X);
title('2. feladat, hur modszer');

end