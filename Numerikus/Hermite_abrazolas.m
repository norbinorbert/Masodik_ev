function Hermite_abrazolas(f, a, b)
Y = [a:0.025:b];
plot(Y, f(Y), 'r');
hold on

xx = linspace(a, b, 6);
fx = f(xx);
syms x
fd = diff(f, x);
fdx = subs(fd, xx);

new_fx = @(y) Hermite(xx, fx, fdx, y);
plot(Y, new_fx(Y), 'b');
end