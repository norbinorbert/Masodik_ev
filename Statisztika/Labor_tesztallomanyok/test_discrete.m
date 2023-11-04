function test_discrete
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [0:6];
distribution_type = 'egyenletes';
parameters = [5];

%our functions
f = DiscretePDF(x, distribution_type, parameters);
F = DiscreteCDF(x, distribution_type, parameters);
subplot(4,2,1);
title('Egyenletes - sajat');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%matlab functions
f = unidpdf(x, parameters(1));
F = unidcdf(x, parameters(1));
subplot(4,2,2);
title('Egyenletes - matlab');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [0:1];
distribution_type = 'bernoulli';
parameters = [2/5, 1];

%our functions
f = DiscretePDF(x, distribution_type, parameters);
F = DiscreteCDF(x, distribution_type, parameters);
subplot(4,2,3);
title('Bernoulli - sajat');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%matlab functions
f = binopdf(x, parameters(2), parameters(1));
F = binocdf(x, parameters(2), parameters(1));
subplot(4,2,4);
title('Bernoulli - matlab');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [2:8];
distribution_type = 'hipergeometrikus';
parameters = [16, 10, 8];

%our functions
f = DiscretePDF(x, distribution_type, parameters);
F = DiscreteCDF(x, distribution_type, parameters);
subplot(4,2,5);
title('Hipergeometrikus - sajat');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%matlab functions
f = hygepdf(x, parameters(1), parameters(2), parameters(3));
F = hygecdf(x, parameters(1), parameters(2), parameters(3));
subplot(4,2,6);
title('Hipergeometrikus - matlab');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [0:20];
distribution_type = 'pascal';
parameters = [12, 1/2];

%our functions
f = DiscretePDF(x, distribution_type, parameters);
F = DiscreteCDF(x, distribution_type, parameters);
subplot(4,2,7);
title('Pascal - sajat');
hold on
plot(x,f,'g*');
stairs(x,F,'r');

%matlab functions
f = nbinpdf(x, parameters(1), parameters(2));
F = nbincdf(x, parameters(1), parameters(2));
subplot(4,2,8);
title('Pascal - matlab');
hold on
plot(x,f,'g*');
stairs(x,F,'r');
end