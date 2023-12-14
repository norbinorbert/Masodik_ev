function Lab10_1_3
X = [501.24, 497.36, 497.54, 498.14, 493.23, 499.76, 498.44, 500.73,...
501.32, 498.01, 499.31, 500.75, 498.26, 500.15, 490.18];

mu_0 = 500;
alpha = 0.05;
[ci_t, ci_mu, t_value, p_value, H] = TTest(X, mu_0, alpha, 'left')

if H == 1
    fprintf('A tasakokban atlagosan kevesebb aszalt gyumolcs van, mint 500g\n');
else
    fprintf('A tasakokban atlagosan nincs kevesebb aszalt gyumolcs, mint 500g\n');
end

% var(X) = 7
X = [104, 100, 102, 98, 103, 99, 100, 97, 107, 102, 103, 100, 98, 102, 100];
% var(Y) = 3.1176
Y = [98, 97, 101, 100, 99, 100, 97, 102, 101, 98, 99, 100, 102, 99, 101, 96, 99];

alpha = 0.08;
[ci_t, ci_delta, t_value, p_value, H] = TTest2D(X, Y, 0, alpha, 'right')

if H == 1
    fprintf('A masodik gep atlagosan rovidebb acelszalagokat vag, mint az elso gep\n');
else
    fprintf('A masodik gep atlagosan nem vag rovidebb acelszalagokat, mint az elso gep\n');
end

end