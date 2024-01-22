% -----------
% Description
% -----------
% The function generates uniformly distributed real random numbers in the range $\Green{\left[\alpha,\beta\right]}$,
% where $\Green{\alpha < \beta}$.
%
% -----
% Input
% -----
% intial_value      - an integer which is required by the uniform integer
%                     random number generator (0 < initial_value < m)
% generator_type    - specifies the type of the used uniform integer radom
%                     number generator, that can be set as 'URNG1'/'URNG2' or 1/2
% [alpha, beta]     - all elements of the output sequence $\Green{\mathbf{Y}}$ will fall in this range
% n                 - the size of the output sequence
%
% ------
% Output
% ------
% $\Green{\mathbf{Y} = \left[Y_i\right]_{i=1}^n}$                  - $\Green{\mathbf{Y} \sim \mathcal{U}\left(\left[\alpha, \beta\right]\right)}$
% new_initial_value - an integer that can be used as an initial value in
%                     case of consecutive random sequence generations
%
function [Y, new_initial_value] = URealRNG(initial_value, generator_type, alpha, beta, n)

switch (generator_type)
    case {'URNG1', 1}
        m = 2^31 - 1;
        [Y, new_initial_value] = URNG1(initial_value, n);
        Y = Y ./ (m - 1);
    case {'URNG2', 2}
        m = 2^31-1;
        [Y, new_initial_value] = URNG2(initial_value, n);
        Y = Y ./ (m-1);
    case {'ULEcuyerRNG', 3}
        Y = ULEcuyerRNG(n);
    case {'UMersenneTwisterRNG', 4}
        Y = UMersenneTwisterRNG(n);
end

Y = alpha + Y .* (beta - alpha);
