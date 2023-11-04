function [X, k] = SOR_modszer(A, b, epszilon, omega)
if (omega < 1 || omega >= 2)
    error('Omega helytelen');
end
if min(eig(A)) < 0
    error('Nem pozitiv definit');
end

n = length(b);
B = zeros(n,n);
for i=1:n
    for j=1:n
       if i~=j
          B(i,j) = -A(i,j)/A(i,i); 
       end
    end
end
NB = norm(B, inf);

X = zeros(n, 1);
X1 = zeros(n, 1);
k = 0;

while true
    k = k + 1;
    for i=1:n
        suma1 = sum(A(i, 1:i-1) * X(1:i-1, 1));
        suma2 = sum(A(i, i+1:n) * X1(i+1:n, 1));
        X(i, 1) = (1-omega)*X1(i,1) + (omega/A(i,i)) * (b(i,1) - suma1 - suma2);
    end
    if (norm(X - X1, inf)) < (((1-NB) / NB) * epszilon)
        break
    end
    X1 = X;
end


end