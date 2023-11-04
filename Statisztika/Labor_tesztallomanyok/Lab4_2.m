function Lab4_2
figure;
subplot(1,2,1);

n = 10000;
X = Elutasitas_modeszere2_altalanos(n, 8, 3);
hist(X);

subplot(1,2,2);
X = Elutasitas_modeszere3_altalanos(n, 8, 3);
hist(X);

end