function Hmf = Hermite(xx, fx, fdx, x)
m = length(xx);
Q = zeros(2*m);
z = zeros(1, 2*m);

for i=1:m
    z(2*i - 1) = xx(i);
    z(2*i) = xx(i);
    
    Q(2*i - 1, 1) = fx(i);
    Q(2*i, 1) = fx(i);
    Q(2*i, 2) = fdx(i);
    
    if i ~= 1
       Q(2*i - 1, 2) = (Q(2*i - 1, 1) - Q(2*i - 2, 1)) / (z(2*i-1) - z(2*i-2));
    end
end

for i = 3:2*m
   for j = 3:i 
       Q(i, j) = (Q(i, j-1) - Q(i-1, j-1)) / (z(i) - z(i-j + 1));
   end
end

Hmf = Q(1, 1);
for i = 2:2*m
    szorzat = Q(i, i);
    for j = 1:i-1
       szorzat = szorzat .* (x - z(j)); 
    end
    Hmf = Hmf + szorzat;
end
end