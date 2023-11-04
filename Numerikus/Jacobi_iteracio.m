function [X, k, B] = Jacobi_iteracio(A, b, epszilon)
if(~dominans_foatlo(A))
    error('Nem dominans foatloju');
end

n = length(b);
X = zeros(n, 1);
X1 = zeros(n, 1);
k = 0;

B = zeros(n,n);
for i=1:n
    for j=1:n
       if i~=j
          B(i,j) = -A(i,j)/A(i,i); 
       end
    end
end
NB = norm(B, inf);

while true
    k = k + 1;
    for i = 1:n
        suma = sum(A(i, 1:i-1) * X1(1:i-1, 1)) + sum(A(i, i+1:n) * X1(i+1:n, 1));
        X(i, 1) = (1/A(i,i)) * (b(i,1) - suma);
    end
    if (norm(X - X1, inf)) < (((1-NB) / NB) * epszilon)
       break;
    end
    X1 = X;
end

end