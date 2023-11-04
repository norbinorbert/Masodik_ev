% -----------
% Description
% -----------
% The function evaluates the values of different continuous cumulative distribution
% functions.
%
% -----
% Input
% -----
% $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$                   - an increasing sequence of $\text{\Red{\textbf{real}}}$ numbers
%
% distribution_type  - a string that identifies the distribution (e.g., 'exponential',
%                      'normal', 'chi2', 'gamma', 'beta', 'Student', etc.)
%
% parameters         - an array of parameters which characterize the distribution
%                      specified by distribution_type
%
% ------
% Output
% ------
% $\Green{ \mathbf{F} = \left[F_i\right]_{i=1}^n = \left[F(x_i)\right]_{i=1}^n }$                   - values of the given cumulative distribution function(*@\framebreak@*)
% ----
% Hint
% ----
% Since the input sequence $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n\subset \mathbb{R}}$ is increasing it is sufficient to calculate
% the values
%
% $\Green{ F_1 = \displaystyle\int_{x_{\min}}^{x_1} f\left(t\right)\text{d}t,\, F_2 = F_1 + \displaystyle\int_{x_1}^{x_2}f\left(t\right)\text{d}t, \ldots,\, F_n = F_{n-1} + \displaystyle\int_{x_{n-1}}^{x_n} f\left(t\right)\text{d}t}$,
%
% where $\Green{f}$ denotes the probability density function that corresponds to $\Green{F}$ and $\Green{x_{\min}}$
% represents the minimal value of the random variable (e.g., in case of the gamma
% distribution $\Green{x_{\min} = 0}$, while in the case of the normal distribution $\Green{x_{\min} = -\infty}$).
%
function F = ContinuousCDF(x, distribution_type, parameters)
sort(x);

f = @(x) ContinuousPDF(x, distribution_type, parameters);

n = length(x);
F = zeros(1,n);

F(1) = integral(f, -Inf, x(1));
for i=2:n
    F(i) = F(i-1) + integral(f, x(i-1), x(i));
end

end

