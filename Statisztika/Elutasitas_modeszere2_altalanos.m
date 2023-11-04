function X = Elutasitas_modeszere2_altalanos(n, mu, sigma)
X = zeros(1, n);

for i=1:n
    while true
        Y = ExactInversion('exp', sigma, 1);
        V = URealRNG(1, 4, -1, 1, 1);
        if (Y-1)^2 < -2*log(abs(V))
            break
        end
    end
    X(i) = Y * sign(V) * sigma + mu;
end

end