function Lab4_3(x)
c = 27/(2*exp(2));

n = length(x);
f = zeros(1, n);
cg = zeros(1, n);

for i=1:n 
    if(x(i) < 0)
        f(i) = 0;
        cg(i) = 0;
    else
        f(i) = 108 * x(i)^2 * exp(-6*x(i));
        cg(i) = c * 2 * exp(-2*x(i));
    end
end

figure;
subplot(1,2,1);
plot(x, f, 'g');
hold on
plot(x, cg, 'r');
title('f - zold | c*g - piros');

f = @(x) 108 * x^2 * exp(-6*x);
g = @(x) 2 * exp(-2*x);
X = Elutasitas_modszere_Lab4(f, c, g, 10000);
subplot(1,2,2);
hist(X, 20);
title('Mintavetelezes hisztogramja');

end