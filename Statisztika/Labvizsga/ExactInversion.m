function X = ExactInversion(distribution_type, parameters, n)
X = zeros(1,n);
switch (distribution_type)
    case 'exp'
        lambda = parameters(1);
        if lambda <= 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = -(1/lambda) * log(U);
        end
        
    case 'Cauchy'
        sigma = parameters(1);
        if sigma <= 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = sigma*tan(pi*U);
        end
        
    case 'Rayleigh'
        sigma = parameters(1);
        if sigma <= 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = sigma * sqrt(-2*log(U));
        end
        
    case 'haromszogu'
        a = parameters(1);
        if a < 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = a*(1-sqrt(U));
        end
        
    case 'Rayleigh-veg'
        a = parameters(1);
        if a <= 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = sqrt(a^2 - 2*log(U));
        end
        
    case 'Pareto'
        a = parameters(1);
        b = parameters(2);
        if a <= 0 || b <= 0
            error('Rossz parameter!\n');
        end
        for i=1:n
            U = UMersenneTwisterRNG;
            X(i) = b/((1-U)^(1/a));
        end
        
    case 'Lab3_1'
        for i=1:n
            U = UMersenneTwisterRNG;
            if(U<=4/9)
                X(i) = (sqrt(54*U + 1) - 1) / 6;
            else
                X(i) = (5 - sqrt(17 - 8*U)) / 2;
            end
        end
        
    case 'Lab8_2'
        for i=1:n
            theta = parameters(1);
            U = UMersenneTwisterRNG;
            X(i) = (1/theta) * (1/(1-U))^(1/3);
        end
        
    case 'Lab12_5'
        for i=1:n
           theta = parameters(1);
           U = UMersenneTwisterRNG;
           X(i) = sqrt(-(2*theta^2 * log(1-U)) / 3);
        end
        
    case 'Labvizsga'
        for i = 1:n
            U = UMersenneTwisterRNG;
            X(i) = sqrt(12-sqrt(144-135*U));
        end
end

end