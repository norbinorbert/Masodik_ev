function [A] = veges_differencialtablazat(a, h, m, f)
v = [a:h:a+m*h];
A = zeros(m+1, m+2);
A(:, 1) = v;
A(:, 2) = f(v);