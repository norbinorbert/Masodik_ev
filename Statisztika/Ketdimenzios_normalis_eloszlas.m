function Y = Ketdimenzios_normalis_eloszlas(ro, mu1, mu2, sigma1, sigma2, n)
Y = zeros(n, 2);

mu = [mu1; mu2];
%sigma = [sigma1^2, ro*sigma1*sigma2; ro*sigma1*sigma2, sigma2^2];
L = [sigma1^2, 0; ro*sigma2, sqrt(1-ro^2)*sigma2];
T = 2*pi;

for i=1:n
   U1 = UMersenneTwisterRNG;
   U2 = UMersenneTwisterRNG;
   R = sqrt(-2*log(U1));
   theta = T*U2;
   X = [R*cos(theta); R*sin(theta)];
   Y(i, :) = mu + L*X;
end

end