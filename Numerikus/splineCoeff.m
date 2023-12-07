function C = splineCoeff(xx, fx)
n = length(xx);

h = zeros(1, n);
for j = 1:n-1
    h(j+1) = xx(j+1) - xx(j);
end

lambda = zeros(1,n);
mu = zeros(1,n);
d = zeros(1,n);

for j = 2:n-1
   lambda(j) = h(j+1) / (h(j) + h(j+1));
   mu(j) = 1 - lambda(j);
   d(j) = (6 / (h(j) + h(j+1))) * (((fx(j+1) - fx(j)) / h(j+1)) - ((fx(j) - fx(j-1)) / h(j)));
end
lambda(1) = 1;
d(1) = 0;
mu(n) = 1;
d(n) = 0;
mu(1) = 0;
lambda(n) = 0;

A = 2*eye(n) + diag(mu(2:n), -1) + diag(lambda(1:n-1), 1);

M = A \ d';
M = M';

alfa = zeros(1, n-1);
beta = zeros(1, n-1);
gamma = zeros(1, n-1);
delta = zeros(1, n-1);

for j = 1:n-1
    alfa(j) = fx(j);
    beta(j) = ((fx(j+1) -fx(j)) / h(j+1)) - ((2*M(j) + M(j+1)) / 6) * h(j+1);
    gamma(j) = M(j) / 2;
    delta(j) = (M(j+1) - M(j)) / (6 * h(j+1));
end

C = zeros(4, n-1);
for j = 1:n-1
   C(:, j) = [alfa(j); beta(j); gamma(j); delta(j)]; 
end

end