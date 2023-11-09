function Aitken_modszer(xx, fx, x, epszilon)
n = length(xx);

for i=1:n-1
    for j=i+1:n
        dist1 = abs(xx(i) - x);
        dist2 = abs(xx(j) - x);
        if(dist1 > dist2)
            tmp = xx(i);
            xx(i) = xx(j);
            xx(j) = tmp;
            
            tmp = fx(i);
            fx(i) = fx(j);
            fx(j) = tmp;
        end
    end
end

utolso = 1;

Q(:, 1) = fx(:);
for i=2:n
    for j=2:i
        Q(i, j) = ((xx(i)-x)*Q(j-1,j-1) - (xx(j-1)-x)*Q(i,j-1)) / (xx(i) - xx(j-1));
    end
    
    utolso = i;
    if abs(Q(i, i) - Q(i-1, i-1)) <= epszilon
        break;
    end
end

if utolso == n && abs(Q(n, n) - Q(n-1, n-1)) > epszilon
    error('A megadott csomopontszam nem elegendo a kert pontossag eleresehez');
end

Q(utolso, utolso)

end