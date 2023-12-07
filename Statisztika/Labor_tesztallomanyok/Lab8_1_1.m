function n = Lab8_1_1(alpha,epsilon, experiment_count)

n = 350;
mu = 1/4;
Y = [0,1; 1-mu, mu];
p = 0;
while p < (1 - alpha)
    n = n + 1;
    kedv = 0;
    for i = 1 : experiment_count
        X = InversionBySequentialSearch(Y, 2, n);
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