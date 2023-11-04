% -----------
% Description
% -----------
% The function implements the linear congruential(*@\footnote{\textbf{congruence} \emph{kongruencia}; \textbf{(combined) multiplicative linear $\sim$} \emph{(összetett) multiplikatív lineáris kongruencia}}@*) generator $\Green{X_{i+1} = \left(aX_{i} +c \right) \operatorname{mod} m,\,i \ge 2}$.
%
% -----
% Input
% -----
% m                 - the modulus(*@\footnote{\textbf{modulus} \emph{osztó}}@*) $\Green{m > 0}$
% a                 - the multiplier(*@\footnote{\textbf{multiplier} \emph{szorzó}}@*) $\Green{a \in \left\{0,1,\ldots,m-1\right\}}$
% c                 - the increment(*@\footnote{\textbf{increment} \emph{növekedmény}}@*) $\Green{c \in \left\{0,1,\ldots,m-1\right\}}$
% initial_value     - an integer that represents the first element of the
%                     generated sequence (0 < intial_value < m)
% n                 - the size of the output sequence
%
% ------
% Output
% ------
% $\Green{\mathbf{X} = \left[X_i\right]_{i=1}^n}$                  - an array of uniformly distributed integer random numbers(*@\footnote{\textbf{number} \emph{szám}; \textbf{(pseudo)random $\sim$} \emph{(ál) véletlen szám}; \textbf{random $\sim$ generator} \emph{véletlenszám-generátor}}@*)
% new_initial_value - an integer that can be used as an initial value in case
%                     of consecutive random sequence generations
function [X, new_initial_value] = LinearCongruentialGenerator(m, a, c, initial_value, n)

X = zeros(1, n);
X(1) = initial_value;

for i = 2:n
    X(i) = mod(a * X(i-1) + c, m);
end

new_initial_value = mod(a * X(n) + c, m);