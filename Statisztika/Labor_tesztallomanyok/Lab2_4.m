function [] = Lab2_4
figure
x = [1:9];
distribution_type = '+';
parameters = [];

f = DiscretePDF(x, distribution_type, parameters);
F = DiscreteCDF(x, distribution_type, parameters);
hold on
plot(x,f,'g*');
stairs(x,F,'r');

P = 0;
for i=1:6
    P = P + f(i);
end
fprintf('P(X<=6) = %f\n',  P);

P = 0;
for i=3:9
    P = P + f(i);
end
fprintf('P(X>=3) = %f\n',  P);

P = 0;
for i=2:6
    P = P + f(i);
end
fprintf('P(2<=X<7) = %f\n',  P);
end