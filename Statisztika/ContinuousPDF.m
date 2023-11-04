% -----------
% Description
% -----------
% The function evaluates different continuous probability density functions.
%
% -----
% Input
% -----
% $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$                   - an increasing sequence of $\text{\Red{\textbf{real}}}$ numbers
% distribution_type  - a string that identifies the distribution (e.g., 'exponential',
%                      'normal', 'chi2', 'gamma', 'beta', 'Student', etc.)
% parameters         - an array of parameters which characterize the distribution
%                      specified by distribution_type
%
% ------
% Output
% ------
% $\Green{\mathbf{f} = \left[f_i\right]_{i=1}^n  = \left[f(x_i)\right]_{i=1}^n}$                   - values of the given probability density function
%
function f = ContinuousPDF(x, distribution_type, parameters)

% for safety reasons
x = sort(x);

% get the size of the input array
l = length(x);
% select the corresponding distribution
switch (distribution_type)
    
    case 'normal'
        % the $\Green{\mathcal{N}\left(\mu,\sigma\right)}$-distribution has two parameters, where $\Green{\mu\in\mathbb{R}}$ and $\Green{\sigma>0}$
        mu    = parameters(1);
        sigma = parameters(2);
        
        % check the validity of the distribution parameters
        if (sigma <= 0)
            error('The standard deviation must be a strictly positive number!');
        end
        
        % Allocate memory and evaluate the probability density function $\Green{f_{\mathcal{N}\left(\mu,\sigma\right)}}$
        % for each element of the input array $\Green{\mathbf{x} = \left[x_i\right]_{i=1}^n}$.
        %
        % Note that, in this special case, this can be done in a single line of code,
        % provided that one uses the dotted arithmetical operators of $\GMatlab{}$.
        
        % use the formula $\Green{f_{\mathcal{N}\left(\mu,\sigma\right)}\left(x_i\right) = \displaystyle\frac{1}{\sqrt{2\pi}\,\sigma} e^{-\frac{\left(x_i-\mu\right)^2}{2\sigma^2}},\,x_i \in \mathbb{R} }$
        f = (1.0 / sqrt(2.0 * pi) / sigma) * exp(-(x - mu).^ 2 / 2.0 / sigma^2);
        
    case 'exp'
        lambda = parameters(1);
        if lambda <= 0
            error('Rossz parameter!');
        end
        f = zeros(1,l);
        for i=1:l
            if(x(i)<=0)
                f(i) = 0;
            else
                f(i) = lambda * exp(-lambda*x(i));
            end
        end
        
        %Pearson-fele (4)
    case 'pearson'
        n = parameters(1);
        sigma = parameters(2);
        if(sigma <= 0)
            error('Rossz parameter! (sigma)');
        end
        if(n<1)
            error('Rossz parameter1 (n)');
        end
        
        f = zeros(1, l);
        
        for i=1:l
            if(x(i) <= 0)
                f(i) = 0;
            else
                f(i) = ((x(i)^(n/2 - 1) * exp((-x(i)) / (2*sigma^2))) / (2^(n/2) * sigma^n * gamma(n/2)));
            end
        end
        
    case 'gamma'
        a = parameters(1);
        b = parameters(2);
        if(a<=0 || b<=0)
            error('Rossz parameter!');
        end
        f = zeros(1,l);
        
        for i=1:l
           if(x(i) <= 0)
               f(i) = 0;
           else
               f(i) = 1 / (b^a * gamma(a)) * x(i)^(a - 1) * exp(1)^(-1 * x(i) / b);
           end
        end
        
        %Beta (6)
    case 'beta'
        a = parameters(1);
        b = parameters(2);
        if(a<=0)
            error('Rossz parameter! (a)');
        end
        if(b<=0)
            error('Rossz parameter! (b)');
        end
        f=zeros(1,l);
        for i=1:l
            if(x(i) <=0 || x(i) >= 1)
                f(i) = 0;
            else
                f(i) = (1/beta(a, b)) * (x(i)^(a-1)) * ((1-x(i))^(b-1));
            end
        end
        
        %Student-fele (7)
    case 'student'
        n = parameters(1);
        if(n<1)
            error('Rossz parameter!');
        end
        f = ((gamma((n+1)/2) / (sqrt(n * pi) * gamma(n/2)))) * ((1 + (x.^2 / n)).^(-((n+1)/2)));
        
        %Snedecor-Fisher-fele (8)
    case 'snedecor'
        m = parameters(1);
        n = parameters(2);
        if(m<=0)
            error('Rossz parameter! (m)')
        end
        if(n<=0)
            error('Rossz parameter! (n)')
        end
        
        f = zeros(1,l);
        for i=1:l
            if(x(i)<0)
                f(i) = 0;
            else
                f(i) =  (1/beta(m/2, n/2))* (m/n)^(m/2) * (x(i)^(m/2-1) / (1+m/n*x(i))^((m+n)/2));
            end
        end
        
    case '+'
        f = zeros(1,l);
        for i=1:l
            if(x(i) <= -1)
                f(i) = 0;
            else if (x(i) > -1 && x(i) <= 1)
                    f(i) = (1/9)*(x(i)+3);
                else if(x(i)>1 && x(i)<=2)
                        f(i) = (x(i)/18)*(1/6 + x(i)^2);
                    else if (x(i) > 2)
                            f(i) = (1/9)*(exp(2-x(i)));
                        end
                    end
                end
            end
        end
        
    case 'Lab3_1'
        f = zeros(1,l);
        for i=1:l
            if(x(i)<= 0 || x(i) > 1)
                f(i) = 0;
            else if (x(i) > 0 && x(i)<= 2/3)
                    f(i) = (4*x(i)/3) + 2/9;
                else if(x(i) > 2/3 && x(i) <= 1)
                        f(i) = 5/2 - x(i);
                    end
                end
            end
        end
       
    case 'Lab4_1'
        f = zeros(1,l);
        for i=1:l
            if(x(i)<0 || x(i) > 3)
                f(i) = 0;
            else
                f(i) = 1/18*((x^2)*(3-x) + 5/2*x);
            end
        end
end
end