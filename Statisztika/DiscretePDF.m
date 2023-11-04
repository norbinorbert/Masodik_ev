% -----------
% Description
% -----------
% The function calculates the values of different discrete probability density functions.
% -----
% Input
% -----
% $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$                   - an increasing sequence(*@\footnote{\textbf{sequence} \emph{sorozat}; \textbf{increasing $\sim$} \emph{növekv\H{o} sorozat}; \textbf{random $\sim$} \emph{véletlen sorozat}}@*) of $\text{\Red{\textbf{positive integers}}}$
% distribution_type  - a string that identifies the distribution (e.g., 'Bernoulli',
%                      'binomial', 'Poisson', 'geometric', etc.)
% parameters         - an array of parameters which characterize the distribution
%                      specified by distribution_type
% ------
% Output
% ------
% $\Green{\mathbf{f} = \left[f(x_i)\right]_{i=1}^n}$                   - values of the given probability density function
function f = DiscretePDF(x, distribution_type, parameters)

% for safety reasons
sort(x);
x = round(x);

% get the size of the input array
l = length(x);

% select the corresponding distribution
switch (distribution_type)
    
    case 'geometric'
        % the $\Green{\mathcal{G}eo\left(p\right)}$-distribution has a single parameter $\Green{p\in\left[0,1\right]}$
        p = parameters(1);
        
        % check the validity of the distribution parameter $\Green{p}$
        if (p < 0 || p > 1)
            error('Wrong parameter!');
        end
        
        % allocate memory and evaluate the probability density function $\Green{ f_{\mathcal{G}eo\left(p\right) }}$
        % for each element of the input array $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$
        f = zeros(1, l);
        
        q = 1 - p;
        for i = 1:l
            % check the validity of the current value $\Green{x_i}$
            if (x(i) < 1)
                error('Incorrect input data!');
            else
                f(i) = q^(x(i) - 1) * p; % i.e., $\Green{ f_{\mathcal{G}eo\left(p\right) } \left( x_i \right) = \left(1-p\right)^{x_i} \cdot p,\,i=1,2,\ldots,n}$
            end
        end
        
        % egyenletes (1)
    case 'egyenletes'
        n = parameters(1);
        if(n<1)
            error('Hibas parameter!');
        end
        f = zeros(1,l);
        for i=1:l
            if(x(i) > n || x(i) < 1)
                f(i) = 0;
            else
                f(i) = 1/n;
            end
        end
        
        %bernoulli (2)
    case 'bernoulli'
        p = parameters(1);
        if (p < 0 || p > 1)
            error('Rossz parameter!');
        end
        
        f = zeros(1,l);
        
        for i=1:l
            if(x(i) ~= 0 && x(i) ~= 1)
                error('Rossz bemenet');
            end
            if(x(i) == 0)
                f(i) = 1-p;
            else
                f(i) = p;
            end
        end
        
        %hipergeometrikus (4)
    case 'hipergeometrikus'
        N = parameters(1);
        M = parameters(2);
        n = parameters(3);
        
        if(N<1)
            error('Rossz parameter! (N)');
        end
        
        if(M<0 || M>N)
            error('Rossz parameter! (M)');
        end
        
        if(n<0 || n>N)
            error('Rossz parameter! (n)');
        end
        
        f = zeros(1, l);
        
        for i=1:l
            if(x(i) < max(0, n-N+M) || x(i) > min(n, M))
                error('Rossz bemenet');
            end
            f(i) = (factorial(M) / factorial(x(i)) / factorial(M-x(i))) *...
                (factorial(N-M) / factorial(n-x(i)) / factorial(N-M-n+x(i))) /...
                (factorial(N) / factorial(n) / factorial(N-n));
        end
        
        %Pascal-fele (6)
    case 'pascal'
        n = parameters(1);
        p = parameters(2);
        if(n<1)
            error('Rossz parameter! (n)');
        end
        if (p < 0 || p > 1)
            error('Rossz parameter! (p)');
        end
        
        f = zeros(1,l);
        for i=1:l
            if(x(i) < 0)
                error('Rossz bemenet');
            end
            
            f(i) = factorial(n+x(i)-1) / factorial(x(i)) / factorial(n-1) * p^n * (1-p)^x(i);
            
        end
        
    case '+'
        f = [1/12, 1/27, pi/54, 1/9, 2*pi/27, 1/3, 1/36, (8-2*pi)/27, (6-pi)/54];
end

end