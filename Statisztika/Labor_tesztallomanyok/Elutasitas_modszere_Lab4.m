function X = Elutasitas_modszere_Lab4(f, c, g, n)
X = zeros(1, n);

szamlalo=0;
for i=1:n
    while true
       szamlalo = szamlalo+1;
       Y = ExactInversion('exp', 2, 1);
       U = UMersenneTwisterRNG;
       if U <= f(Y)/(c*g(Y));
           break;
       end
    end
    X(i) = Y;
end

fprintf('parok szama: %f\nc=%f\n', szamlalo/n, c);

end