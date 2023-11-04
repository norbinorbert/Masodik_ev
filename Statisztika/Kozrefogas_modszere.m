function X = Kozrefogas_modszere(n)
X = zeros(1,n);
alfa = exp(-1/2);
beta = 1/2;
gamma = sqrt(2);

elfogadas_lepesek = 0;
kiertekeles_szama = 0;

for i=1:n
    while true
        elfogadas_lepesek = elfogadas_lepesek + 1;
        U = UMersenneTwisterRNG;
        V = UMersenneTwisterRNG;
        Y = tan(pi*V);
        S = beta * Y^2;
        W = (alfa*U) / (beta + S);
        if abs(Y) > gamma
            L = false;
        else
            L = (W <= 1-S);
        end
        
        if L == false
            L = (W <= exp(-S));
            kiertekeles_szama = kiertekeles_szama + 1;
        end
        
        if L == true
            break
        end
    end
    X(i) = Y;
end

fprintf('%f lepes alatt fogadunk el egy mintat\n', elfogadas_lepesek/n);
fprintf('%f alkalommal ertekeljuk ki a surusegfuggvenyt\n', kiertekeles_szama/n);
hist(X);

end