function megoldas = Szelomodszer(f, x0, xn, epsz, Nmax)
xn_2 = x0;
xn_1 = xn;

i = 1;
while true
    xn = xn_1 - ((xn_1 - xn_2)*f(xn_1)) / (f(xn_1) - f(xn_2));
    
    if abs(xn - xn_1) < epsz || i == Nmax
        break
    end
    xn_2 = xn_1;
    xn_1 = xn;
    i = i + 1;
end

if i == Nmax
    fprintf('Elertuk a maximum iteracio szamot\n');
end

megoldas = xn;

end