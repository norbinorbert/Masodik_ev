function L = Cholesky(A)
[n, m] = size(A);
if n ~= m
    error('Nem negyzetes');
end

for i=1:n
    for j=i+1:n
        if A(i,j) ~= A(j,i)
            error('Nem szimmetrikus');
        end
    end
end

L = zeros(n, n);

for i=1:n
    for j=1:i
        suma = 0;
        for k=1:j-1
            suma = suma + L(i,k) * L(j,k);
        end
        if (A(i,j) - suma < 0) && (i==j)
            error('Nem pozitiv definit');
        end
        if i~=j
            L(i,j) = (1/L(j, j)) * (A(i,j) - suma);
        else
            L(i,i) = sqrt(A(i,j) - suma);
        end
    end
end

end