function X = Elutasitas_modszere(f, M, a, b, n)
X = zeros(1, n);

for i=1:n
    while true
       U = UMersenneTwisterRNG;
       V = UMersenneTwisterRNG;
       Y = a + (b-a)*V;
       if(U*M) <= f(Y)
           break;
       end
    end
    X(i) = Y;
end


end