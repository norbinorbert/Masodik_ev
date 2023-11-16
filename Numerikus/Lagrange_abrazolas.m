function Lagrange_abrazolas(f, a, b)
X = [a:0.025:b];
plot(X, f(X), 'r');
hold on

xx = linspace(a, b, 51);
fx = f(xx);
new_fx = @(x) Lagrange_polinom_Newton_alakja(xx, fx, x);
plot(X, new_fx(X), 'b');
axis([a b a b])
end
