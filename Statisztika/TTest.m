% -----------
% Description
% -----------
% The function performs a one-sample $\Green{T}$-test of the null hypothesis $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ that the
% data in the vector $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$ comes from an $\Green{\mathcal{N}\left(\DBlue{\mu},\DBlue{\sigma}\right)}$ distribution, where the   
% theoretical mean value $\Green{\DBlue{\mu}\in\mathbb{R}}$ and the theoretical standard deviation $\Green{\DBlue{\sigma}>0}$
% are unknown parameters.
%
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$         - an independent and identically distributed sample of the normal distribu- 
%              tion $\Green{\mathcal{N}\left(\DBlue{\mu},\DBlue{\sigma}\right)}$, where the theoretical mean value $\Green{\DBlue{\mu}\in\mathbb{R}}$ and the theoretical 
%              standard deviation $\Green{\DBlue{\sigma}>0}$ are unknown parameters
% mu_0       - denotes the guess $\Red{\mu_0}$ of the user for the unknown theoretical mean 
%              value $\DBlue{\mu}$
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines 
%              the type of the alternative hypothesis)
% ------
% Output
% ------
% ci_t       - confidence interval for the random variable $\Green{T_n = \displaystyle\frac{\overline{X} - \DBlue{\mu}}{\frac{\overline{\sigma}}{\sqrt{n}}}\sim\mathcal{S}\left(n-1\right)}$
% ci_mu      - confidence interval for theoretical mean value $\DBlue{\mu}$
% t_value    - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ is true
% p_value    - probability of observing the given result, or one more extreme, by  
%              chance if the null hypothesis $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ is true (small $\Blue{p}$-values  
%              cast doubt on the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis,  
%              1 = alternative hypothesis defined by the input parameter tail)
%
function [ci_t, ci_mu, t_value, p_value, H] = TTest(X, mu_0, alpha, tail)

% check the validity of input parameters!
...

% get the size of the sample $\Green{\left\{X_j\right\}_{j=1}^n}$
n = length(X);

% calculate the sample mean $\Green{\overline{X} = \displaystyle\frac{1}{n}\displaystyle\sum_{j=1}^n X_j}$
X_ = sum(X) / n; % or, equivalently, X_ = mean(X);

% calculate the sample standard deviation $\Green{\overline{\sigma} = \sqrt{\displaystyle\frac{1}{n-1}\displaystyle\sum_{j=1}^n\left(X_j - \overline{X}\right)^2}}$
sigma_ = sqrt(sum((X - X_).^2) / (n-1)); % or, equivalently, sigma_ = sqrt(var(X));

% observe that $\Green{ \displaystyle\frac{\overline{\sigma}}{\sqrt{n}} }$ is a constant
s = sigma_ / sqrt(n);

% calculate the t-value $\Red{T_n^0} = \Green{\displaystyle\frac{\overline{X} - \Red{\mu_0}}{\frac{\overline{\sigma}}{\sqrt{n}}}}$
t_value = (X_ - mu_0) / s;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
        % calculate the inverse function value $\Green{\DPurple{t_{1-\frac{\alpha}{2}}} = \DPurple{F_{\mathcal{S}\left(n-1\right)}^{-1}\left(1-\frac{\alpha}{2}\right)}}$
        t = tinv(1 - alpha/2, n-1);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-t_{1-\frac{\alpha}{2}}}, \DPurple{+t_{1-\frac{\alpha}{2}}}\right)}$
        ci_t(1) = -t;
        ci_t(2) =  t;
        
        % store the end points of the confidence interval $\Green{\left(\overline{X} - \frac{\overline{\sigma}}{\sqrt{n}} \DPurple{t_{1-\frac{\alpha}{2}}}, \overline{X} + \frac{\overline{\sigma}}{\sqrt{n}} \DPurple{t_{1-\frac{\alpha}{2}}}\right)}$
        ci_mu(1) = X_ - s * t;
        ci_mu(2) = X_ + s * t;
        
        % calculate the p-value $\Blue{p}\,\Green{ = 2 F_{\mathcal{S}\left(n-1\right)} \left( -\left| \Red{T_n^0} \right|\right)}$
        p_value = 2.0 * tcdf(-abs(t_value), n-1);
        
    case {'right', 1}
        t = tinv(1 - alpha, n-1);
			            
        ci_t(1) = -Inf;
        ci_t(2) =  t;
        
        ci_mu(1) = X_ - s * t;
        ci_mu(2) = Inf;
        
        p_value = 1 - tcdf(t_value, n-1);
        
    case {'left', -1}
    	t = tinv(alpha, n-1);
			            
        ci_t(1) = t;
        ci_t(2) = Inf;
        
        ci_mu(1) = -Inf;
        ci_mu(2) = X_ - s * t;
        
        p_value = tcdf(t_value, n-1);
end

% make your decision based on confidence intervals, and note that, the 
% condition (mu_0 > ci_mu(1) && mu_0 < ci_mu(2)) would also be correct!
H = ~(t_value > ci_t(1) && t_value < ci_t(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end