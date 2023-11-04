function Lab4_3(n)

b = zeros(n,1) + 3;
b(1, 1) = 4;
b(n, 1) = 4;
A = eye(n) * 5;
seged1 = zeros(1,n-1) - 1;
alatta = diag(seged1, -1);
felette = diag(seged1, 1);
A = A + alatta + felette;

[X, k, B] = Jacobi_iteracio(A, b, eps)


[X, k] = SOR_modszer(A, b, eps, 1)

omega = 2/(1+sqrt(1-max(eig(B))^2))
[X, k] = SOR_modszer(A, b, eps, omega)

end