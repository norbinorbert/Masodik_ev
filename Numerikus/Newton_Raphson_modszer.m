function megoldas = Newton_Raphson_modszer(f, df, x0, epsz, Nmax, a, b)
figure
hold on
X = [a:0.025:b];
z = zeros(1, length(X));
plot(X, f(X));
plot(X, z)

xn_1 = x0;
    erinto = @(y) f(xn_1) + (y - xn_1) * df(xn_1);
    
    plot(X, erinto(X));
i = 1;
while true
    xn = xn_1 - f(xn_1) / df(xn_1);
    
    erinto = @(y) f(xn) + (y - xn) * df(xn);
    
    plot(X, erinto(X));
    
    if abs(xn - xn_1) < epsz || i == Nmax
        break
    end
    i = i + 1;
    xn_1 = xn;
    pause(0.5)
end

if i == Nmax
    fprintf('Elertuk a maximum iteracio szamot\n');
end

megoldas = xn;
end