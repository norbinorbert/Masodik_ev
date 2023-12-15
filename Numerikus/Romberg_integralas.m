function megoldas = Romberg_integralas(f, a, b, epsz, Nmax)
h = b - a;

Q(1, 1) = (h/2) * (f(a) + f(b));

k = 2;
while true
    suma = 0;
    for i = 1 : 2^(k-2)
        suma = suma + f(a + (2*i-1)*(h / 2^(k-1))); 
    end
    Q(k, 1) = Q(k-1, 1) / 2 + (h / 2^(k-1)) * suma;
    
    for j = 2 : k
       Q(k, j) = (4^(j-1) * Q(k, j-1) - Q(k-1, j-1)) / (4^(j-1) - 1);
    end
    
    if (abs(Q(k,k) - Q(k-1,k-1)) < epsz) || (k == Nmax)
        break;
    end
    
    k = k + 1;
end

if k == Nmax
    fprintf('Elertuk a max lepesszamot\n');
end
megoldas = Q(k,k);
end