function Lab8_2_2(alfa)
n = 10000;
z = norminv(1-alfa/2);

theta = 1/8;

X = ExactInversion('Lab8_2', theta, n);
X_ = mean(X);

theta_min = (-z/sqrt(n) + sqrt(3)) * sqrt(3) / (2*X_);
theta_max = (z/sqrt(n) + sqrt(3)) * sqrt(3) / (2*X_);
fprintf('%f | %f | %f\n', theta_min, theta, theta_max);

end