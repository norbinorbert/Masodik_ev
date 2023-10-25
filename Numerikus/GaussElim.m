function [U,c] = GaussElim(A,b)
n = length(A);
for i=1:n-1
    [szam , j] = max(abs(A(i:n, i)));
    if(szam == 0)
        fprintf('Szingularis\n');
        break;
    end
    j = j + i - 1;
    
    tmp = A(j, :);
    A(j, :) = A(i, :);
    A(i, :) = tmp;
    
    tmp = b(j, 1);
    b(j, 1) = b(i, 1);
    b(i, 1) = tmp;
    
    for j=i+1:n
       l = A(j, i) / A(i, i);
       A(j,:) =  A(j,:) - l * A(i, :);
       b(j, 1) = b(j, 1) - l * b(i, 1);
    end
    
end
U = A;
c = b;
end