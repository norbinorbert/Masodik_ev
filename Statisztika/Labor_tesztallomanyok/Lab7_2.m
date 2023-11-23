function Lab7_2
f = @(x, y) 1/16 * (x*(1/2 + y) + x + y^2/4 + 1/6);

xa = 0;
xb = 2;
ya = -2;
yb = 2;
M = f(2,2);
n = 10000;
X = Elutasitas_modszere_ketvaltozos(f, M, [xa, xb], [ya, yb], n);

Y = X(:, 2)';
X = X(:, 1)';

fprintf('X elmeleti varhato erteke: %f\n', 5/4);
fprintf('X gyakorlati varhato erteke: %f\n', mean(X));
fprintf('X elmeleti szorasnegyzete: %f\n', 13/48);
fprintf('X gyakorlati szorasnegyzete: %f\n\n', var(X));

fprintf('Y elmeleti varhato erteke: %f\n', 2/3);
fprintf('Y gyakorlati varhato erteke: %f\n', mean(Y));
fprintf('Y elmeleti szorasnegyzete: %f\n', 16/15);
fprintf('Y gyakorlati szorasnegyzete: %f\n\n', var(Y));

Z = 3.*X - Y.^2./2;
fprintf('Z elmeleti varhato erteke: %f\n', 539/180);
fprintf('Z gyakorlati varhato erteke: %f\n', mean(Z));
fprintf('Z elmeleti szorasnegyzete: %f\n', (2503/210) - (539/180)^2);
fprintf('Z gyakorlati szorasnegyzete: %f\n', var(Z));

end