function [] = Lab2_5
x = [-3:0.05:5];
distribution_type = '+';
parameters = [];

%our functions
f = ContinuousPDF(x, distribution_type, parameters);
F = ContinuousCDF(x, distribution_type, parameters);
hold on
plot(x,f,'g');
plot(x,F,'r');

f = @(x) ContinuousPDF(x, distribution_type, parameters);
fprintf('P(X > 0) = %f\n',  integral(f, 0, Inf));
fprintf('P(3/2< X < 3) = %f\n',  integral(f, 3/2, 4));