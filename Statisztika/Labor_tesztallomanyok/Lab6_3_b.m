function Lab6_3_b
mu1 = 2;
mu2 = -3;
mu3 = 4;
mu = [mu1; mu2; mu3];

sigma1 = 1;
sigma2 = 1;
sigma3 = 1;

ro12 = 0.5;
ro13 = 0;
ro23 = -0.5;

sigma = [sigma1^2, ro12*sigma1*sigma2, ro13*sigma1*sigma3;...
         ro12*sigma1*sigma2, sigma2^2, ro23*sigma2*sigma3;...
         ro13*sigma1*sigma3, ro23*sigma2*sigma3, sigma3^2];

n = 10000;
[L, Y] = Tobbdimenzios_normalis_eloszlas(3, mu, sigma, n);
L
figure
plot3(Y(1, :), Y(2,:), Y(3,:), '.');
title('(x,y,z)');

mu1 = 2;
mu2 = -3;
mu3 = 4;
mu4 = 0;
mu = [mu1; mu2; mu3; mu4];

sigma1 = 1;
sigma2 = 1;
sigma3 = 1;
sigma4 = 1;

ro12 = 0.3;
ro13 = 0;
ro14 = -0.5;
ro23 = 0.9;
ro24 = 0.2;
ro34 = 0.1;

sigma = [sigma1^2, ro12*sigma1*sigma2, ro13*sigma1*sigma3, ro14*sigma1*sigma4;...
         ro12*sigma1*sigma2, sigma2^2, ro23*sigma2*sigma3, ro24*sigma2*sigma4;...
         ro13*sigma1*sigma3, ro23*sigma2*sigma3, sigma3^2, ro34*sigma3*sigma4;...
         ro14*sigma1*sigma4, ro24*sigma2*sigma4, ro34*sigma3*sigma4, sigma4^2];

n = 10000;     
P = [1,0,0,0;...
     0,1,0,0;...
     0,0,1,0;...
     0,0,0,0];
[L, Y] = Tobbdimenzios_normalis_eloszlas(4, mu, sigma, n);
L
tempY = P*Y;
figure;
subplot(2,2,1);
plot3(tempY(1, :), tempY(2,:), tempY(3,:), '.');
title('(x,y,z,0)');

P(4,4) = 1;
P(3,3) = 0;
tempY = P*Y;
subplot(2,2,2);
plot3(tempY(1, :), tempY(2,:), tempY(4,:), '.');
title('(x,y,0,q)');

P(3,3) = 1;
P(2,2) = 0;
tempY = P*Y;
subplot(2,2,3);
plot3(tempY(1, :), tempY(3,:), tempY(4,:), '.');
title('(x,0,z,q)');

P(2,2) = 1;
P(1,1) = 0;
tempY = P*Y;
subplot(2,2,4);
plot3(tempY(2, :), tempY(3,:), tempY(4,:), '.');
title('(0,y,z,q)');

end