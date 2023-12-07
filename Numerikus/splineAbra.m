function splineAbra(f, a, b)
X = [a:0.025:b];
plot(X, f(X), 'r');
hold on

xx = linspace(a, b, 11);
fx = f(xx);

new_fx = zeros(1, length(X));
for i = 1 : length(X);
    new_fx(i) = splineFunction(xx, fx, X(i));
end
plot(X, new_fx, 'b');
end