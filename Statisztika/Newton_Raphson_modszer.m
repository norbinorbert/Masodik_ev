function X = Newton_Raphson_modszer(f, F, n, delta, kezdo)
X = zeros(1, n);
Fkicsi = F(2/100);
Fnagy = F(25);
for i=1:n
    U = URealRNG(0, 4, Fkicsi, Fnagy, 1);
    seged = kezdo;
    ertek = seged - ((F(seged) - U) / f(seged));
    while(ertek < 0)
        seged = seged / 2;
        ertek = seged - ((F(seged) - U) / f(seged));
    end
    kezdo = ertek;
    iteraciok = 0;
    while true
        iteraciok = iteraciok + 1;
        seged = seged - ((F(seged) - U) / f(seged));
        if abs(F(seged) - U) <= delta || (iteraciok == 1000)
            break
        end
    end
    if(iteraciok >= 1000)
        i = i - 1;
    else
        X(i) = seged;
    end
end

end