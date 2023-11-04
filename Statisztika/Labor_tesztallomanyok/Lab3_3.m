function Lab3_3
figure;

f = @(x) ContinuousPDF(x, 'gamma', [5/6, 8]);
F = @(x) ContinuousCDF(x, 'gamma', [5/6, 8]); 

n = 7000;
delta = 0.01;
kezdo = 2/100;
X = Newton_Raphson_modszer(f, F, n, delta, kezdo);
subplot(1, 2, 1);
hist(X);

f = @(x) ContinuousPDF(x, 'gamma', [4, 2]);
F = @(x) ContinuousCDF(x, 'gamma', [4, 2]);

kezdo = 6;
X = Newton_Raphson_modszer(f, F, n, delta, kezdo);
subplot(1, 2, 2);
hist(X);

end