% -----------
% Description
% -----------
% By means of parameters m = 2^31-1, a= 2^16+1 and c = 0, the function implements a specialized
% version of the linear congruential generator X{i+1} = (a*X{i} +c){mod} m, i >= 2.
% -----
% Input
% -----
% initial_value     - an integer that must be >= 1, < 2^31-1 and odd and which represents
%                     the first element of the output sequence
% n                 - the size of the output sequence
% ------
% Output
% ------
% $\Green{\mathbf{X} = \left[X_i\right]_{i=1}^n}$                  - a sequence of uniformly distributed integer random numbers
% new_initial_value - an integer that can be used as an initial value in
%                     case of consecutive random sequence generations
function [X, new_initial_value] = URNG2(initial_value, n)

if(mod(initial_value, 2) ~= 1 )
    error('first parameter must be odd');
end;

m = 2^31-1;
a = 2^16+1;
c = 0;
[X, new_initial_value] = LinearCongruentialGenerator(m, a, c, initial_value, n);