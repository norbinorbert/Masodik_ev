function sx = splineFunction(xx, fx, x)
    C = splineCoeff(xx, fx);
    i = 1;
    while true
        if x >= xx(i) && x <= xx(i+1)
            break
        end
        i = i + 1;
    end
    alfa = C(1, i);
    beta = C(2, i);
    gamma = C(3, i);
    delta = C(4, i);
    
    sx = alfa + beta*(x - xx(i)) + gamma * (x - xx(i))^2 + delta * (x - xx(i))^3;
end