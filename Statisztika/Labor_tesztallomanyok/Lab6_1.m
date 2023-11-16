function Lab6_1

n = 10000;
X = Marsaglia(n);
figure;
title('Marsaglia');
subplot(1, 2, 1);
plot(X(:,1), X(:,2), '.');
subplot(1, 2, 2);
hist3(X);

ro = -0.91;
mu1 = 20;
sigma1 = 3;
mu2 = -5;
sigma2 = 1;
X = Ketdimenzios_normalis_eloszlas(ro, mu1, mu2, sigma1, sigma2, n);
figure;
title('Ketdimenzios normalis eloszlas');
subplot(1, 2, 1);
plot(X(:,1), X(:,2), '.');
subplot(1, 2, 2);
hist3(X);

end