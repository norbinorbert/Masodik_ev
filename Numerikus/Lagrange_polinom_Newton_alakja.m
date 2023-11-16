function Lmf = Lagrange_polinom_Newton_alakja(xx, fx, x)
n = length(xx);

L(:,1) = fx;

for j=2:n
    for i=1:n-j+1
        L(i, j) = (L(i+1, j-1) - L(i, j-1)) / (xx(i+j-1) - xx(i));
    end
end

v = L(1, :);

Lmf = v(n);
for i=n-1:-1:1
    Lmf = Lmf.*(x-xx(i)) + v(i);
end

end