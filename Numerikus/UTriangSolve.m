function x = UTriangSolve(U,c)
n = length(U);
x = zeros(n, 1);

for i=n:-1:1
    suma = 0;
    for j=i+1:n 
        suma = suma + U(i,j) * x(j, 1);
    end
    x(i, 1) = 1/U(i,i) * (c(i, 1) - suma);
end

end