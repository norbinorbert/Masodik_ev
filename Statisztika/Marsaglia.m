function X = Marsaglia(n)

X = zeros(n,2);

for i = 1:n
    while true
        U1 = UMersenneTwisterRNG;
        U2 = UMersenneTwisterRNG;
        Z1 = 2*U1 - 1;
        Z2 = 2*U2 - 1;
        S = Z1^2 + Z2^2;
        if 0 < S && S <= 1
            break
        end
    end
    T = sqrt(-2*log(S)/S);
    X(i, 1) = T * Z1;
    X(i, 2) = T * Z2;
end

end