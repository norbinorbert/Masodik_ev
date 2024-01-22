%Boda Norbert, bnim2219
function feladat3
n = 20000;
X = ExactInversion('Labvizsga', [], n);
hist(X);

Ex = mean(X)

Y = 3*X + 1;
Ey = mean(Y);
cov = (1 / (n-1)) .* sum((X - Ex).*(Y-Ey))
end