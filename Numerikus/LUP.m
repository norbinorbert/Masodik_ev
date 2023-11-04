function [L, U, P] = LUP(A)
[n, m] = size(A);
if n ~= m
    error('Nem negyzetes');
end

P = eye(n);
L = zeros(n, n);

for i=1:n-1
    [szam , j] = max(abs(A(i:n, i)));
    if(szam == 0)
        error('Szingularis\n');
    end
    j = j + i - 1;
    
    tmp = A(j, :);
    A(j, :) = A(i, :);
    A(i, :) = tmp;
    
    tmp = P(j, :);
    P(j, :) = P(i, :);
    P(i, :) = tmp;
    
    tmp = L(j, :);
    L(j, :) = L(i, :);
    L(i, :) = tmp;
    
    for j=i+1:n
       l = A(j, i) / A(i, i);
       L(j,i) = l;
       A(j,:) =  A(j,:) - l * A(i, :);
    end
end

U = A;
L = L + eye(n);

end