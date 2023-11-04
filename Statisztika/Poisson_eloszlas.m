function X = Poisson_eloszlas(lambda, r)
if lambda < 0
    error('Rossz parameter\n');
end

X = zeros(1, r);

for k=1:r
   U = UMersenneTwisterRNG;
   i = 0;
   p = exp(-lambda);
   S = p;
   while(U>S)
       i = i + 1;
       p = (lambda/i)*p;
       S = S + p;
   end
   X(k) = i;
end

end