function X = Elutasitas_modszere_ketvaltozos(f, M, a, b, n)
X = zeros(n, 2);

for i=1:n
    while true
       U = UMersenneTwisterRNG;
       V = UMersenneTwisterRNG;
       W = UMersenneTwisterRNG;
       X1 = a(1) + (a(2) - a(1)) * V;
       Y1 = b(1) + (b(2) - b(1)) * W;
       if(U*M) <= f(X1, Y1)
           break;
       end
    end
    X(i, 1) = X1;
    X(i, 2) = Y1;
end


end