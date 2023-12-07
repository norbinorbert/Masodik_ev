function Lab8_2_1(alfa)
n = 10000;
m=8;
z = norminv(1-alfa/2);

p = 2/3;

Y = zeros(2, m+1);
Y(1, :) = 0:m;
Y(2, :) = DiscretePDF(0:m, 'binomial', [m, p]);
Y(2, m+1) = 1 - sum(Y(2, 1:m));

X = InversionBySequentialSearch(Y, 2, n);
X_ = mean(X);
a = 8 + z^2/n;
b = -(2*X_ + z^2/n);
c = X_^2/8;
delta = b^2 - 4*a*c;
p_min = (-b - sqrt(delta)) / (2*a);
p_max = (-b + sqrt(delta)) / (2*a);
fprintf('%f | %f | %f\n', p_min, p, p_max);

end