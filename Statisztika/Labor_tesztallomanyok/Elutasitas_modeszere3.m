function X = Elutasitas_modeszere3(n)
X = zeros(1, n);

a = sqrt(exp(1)) / 2;

for i=1:n
    while true
        U = UMersenneTwisterRNG;
        V = UMersenneTwisterRNG;
        Y = tan(pi*V);
        S = Y^2;
        if U <= a*(1+S)*exp(-S/2)
            break
        end
    end
    X(i) = Y;
end

end