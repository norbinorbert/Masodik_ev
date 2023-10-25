function [] = Lab1_2(m)
for k=1:m
    H = zeros(k, k);
    for i=1:k
        for j=1:k
            H(i, j) = 1 / (i+j-1);
        end
    end
    C = norm(H, Inf) * norm(inv(H), Inf);
    fprintf('k = %d, cond = %f\n', i, C);
end

end