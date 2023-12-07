function n = Lab8_1_2(alpha,epsilon,experiment_count)

mu = 2800;
sigma = 708;
p = 0;
n = 0;
while p < (1 - alpha)
    n = n + 1;
    kedv = 0;
    for i = 1 : experiment_count
        X = Kozrefogas_modszere_altalanos(n, mu, sigma);
        if (abs(mean(X) - mu) < epsilon)
            kedv = kedv + 1;
        end
    end
    p = kedv / experiment_count;
    stem(n,p);
    drawnow
    hold on
end

end