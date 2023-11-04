% -----------
% Description
% -----------
% The function evaluates the values of different discrete cumulative distribution
% functions.
%
% -----
% Input
% -----
% $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$                   - an increasing sequence of $\text{\Red{\textbf{positive integers}}}$
%
% distribution_type  - a string that identifies the distribution (e.g., 'Bernoulli',
%                      'binomial', 'Poisson', 'geometric', etc.)
%
% parameters         - an array of parameters which characterize the distribution
%                      specified by distribution_type(*@\framebreak@*)
% ------
% Output
% ------
% $\Green{ \mathbf{F} = \left[F_i\right]_{i=1}^n = \left[F(x_i)\right]_{i=1}^n }$                   - values of the given cumulative distribution function
%
% ----
% Hint
% ----
% Since the input sequence $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n\subset \mathbb{N}}$ is increasing it is sufficient to calculate
% the values
%
% $\Green{ F_1 = \displaystyle\sum_{i=i_{\min}}^{x_1} f\left(i\right),\, F_2 = F_1 + \displaystyle\sum_{i = x_1 + 1}^{x_2}f\left(i\right), \ldots,\, F_n = F_{n-1}+\displaystyle\sum_{i = x_{n-1}+1}^{x_n} f\left(i\right)}$,
%
% where $\Green{f}$ denotes the probability density function that corresponds to $\Green{F}$ and $\Green{i_{\min}}$
% represents the minimal integer value of the distribution (e.g., in case of the
% geometric distribution $\Green{i_{\min} = 1}$, while in the case of the Poisson distribution $\Green{i_{\min} = 0}$).
%
function F = DiscreteCDF(x, distribution_type, parameters)
sort(x);

f = @(x) DiscretePDF(x, distribution_type, parameters);

switch (distribution_type)
    case 'geometric'
        x_min = 1;
        
    case 'egyenletes'
        x_min = 1;
        
    case 'bernoulli'
        x_min = 0;
        
    case 'hipergeometrikus'
        N = parameters(1);
        M = parameters(2);
        n = parameters(3);
        x_min = max(0, n-N+M);
        
    case 'pascal'
        x_min = 0;
        
    case '+'
        f = DiscretePDF(x, distribution_type, parameters);
        F = zeros(1, 9);
        F(1) = f(1);
        for i=2:9
            F(i) = F(i-1) + f(i);
        end
        return
end

n = length(x);
F = zeros(1,n);
if(x(1) < 0)
    error('Hibas bemenet!');
end
F(1)=sum(f(x_min:x(1)));

for i=2:n
    if(x(i) < 0)
        error('Hibas bemenet!');
    end
    F(i) = F(i-1) + sum(f(x(i-1)+1:x(i)));
end

end
