function test_continuous
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
x = [-3:0.05:20];
distribution_type = 'pearson';
parameters = [5,1];

%our functions
f = ContinuousPDF(x, distribution_type, parameters);
F = ContinuousCDF(x, distribution_type, parameters);
subplot(4,2,1);
title('Pearson - sajat');
hold on
plot(x,f,'g');
plot(x,F,'r');

%matlab functions
f = chi2pdf(x, parameters(1));
F = chi2cdf(x, parameters(1));
subplot(4,2,2);
title('Pearson - matlab');
hold on
plot(x,f,'g');
plot(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [0:0.025:1];
distribution_type = 'beta';
parameters = [3,2];

%our functions
f = ContinuousPDF(x, distribution_type, parameters);
F = ContinuousCDF(x, distribution_type, parameters);
subplot(4,2,3);
title('Beta - sajat');
hold on
plot(x,f,'g');
plot(x,F,'r');

%matlab functions
f = betapdf(x, parameters(1), parameters(2) );
F = betacdf(x, parameters(1), parameters(2));
subplot(4,2,4);
title('Beta - matlab');
hold on
plot(x,f,'g');
plot(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [-3:0.025:3];
distribution_type = 'student';
parameters = [20];

%our functions
f = ContinuousPDF(x, distribution_type, parameters);
F = ContinuousCDF(x, distribution_type, parameters);
subplot(4,2,5);
title('Student - sajat');
hold on
plot(x,f,'g');
plot(x,F,'r');

%matlab functions
f = tpdf(x, parameters(1));
F = tcdf(x, parameters(1));
subplot(4,2,6);
title('Student - matlab');
hold on
plot(x,f,'g');
plot(x,F,'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = [-3:0.025:3];
distribution_type = 'snedecor';
parameters = [6,3];

%our functions
f = ContinuousPDF(x, distribution_type, parameters);
F = ContinuousCDF(x, distribution_type, parameters);
subplot(4,2,7);
title('Snedecor - sajat');
hold on
plot(x,f,'g');
plot(x,F,'r');

%matlab functions
f = fpdf(x, parameters(1), parameters(2));
F = fcdf(x, parameters(1), parameters(2));
subplot(4,2,8);
title('Snedecor - matlab');
hold on
plot(x,f,'g');
plot(x,F,'r');

end