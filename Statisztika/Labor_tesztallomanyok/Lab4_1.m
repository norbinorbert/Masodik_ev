function Lab4_1

f = @(x) ContinuousPDF(x, 'Lab4_1', []);

M = (1/4) + (11/54)*sqrt(11/6);
a = 0;
b = 3;
n = 10000;
X = Elutasitas_modszere(f, M, a, b, n);

hist(X);

end