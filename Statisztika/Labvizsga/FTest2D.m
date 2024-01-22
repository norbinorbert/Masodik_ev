% -----------
% Description
% -----------
% The function performs a two-sample $\Green{F}$-test of the null hypothesis $\Green{H_0 : \DBlue{\lambda^2 = \displaystyle\frac{\DBlue{\sigma_1^2}}{\DBlue{\sigma_2^2}}}  = \Red{1}}$ 
% that the data in the two independent samples $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$ and $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$, of 
% random variables $\Green{X\sim\mathcal{N}\left(\mu_1,\DBlue{\sigma_1}\right)}$ and $\Green{Y\sim\mathcal{N}\left(\mu_2,\DBlue{\sigma_2}\right)}$, come from distributions  
% with equal theoretical standard deviations.
%
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$         - an independent and identically distributed sample of the normal  
%              distribution $\Green{\mathcal{N}\left(\mu_1,\DBlue{\sigma_1}\right)}$, where $\Green{\DBlue{\sigma_1>0}}$ is unknown
% $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$         - an independent and identically distributed sample of the normal 
%              distribution $\Green{\mathcal{N}\left(\mu_2,\DBlue{\sigma_2}\right)}$, where $\Green{\DBlue{\sigma_2>0}}$ is unknown
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines  
%              the type of the alternative hypothesis)
%

% ------
% Output
% ------
% ci_f       - confidence interval for the random variable $\Green{F_{m,n} = \displaystyle\frac{1}{\DBlue{\lambda^2}}\cdot \displaystyle\frac{\overline{\sigma}_1^2}{\overline{\sigma}_2^2}}$
%
% ci_lambda  - confidence interval for the ratio $\Green{\DBlue{\lambda = \displaystyle\frac{\DBlue{\sigma_1}}{\DBlue{\sigma_2}}}}$ of the theoretical standard 
%              deviations
% f_value    - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\lambda^2}  = \Red{1}}$ is true
% p_value    - probability of observing the given result, or one more extreme,  
%              by chance if the null hypothesis $\Green{H_0 : \DBlue{\lambda^2} = \Red{1}}$ is true (small $\Blue{p}$-values 
%              cast doubt on the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis, 
%              1 = alternative hypothesis defined by the input parameter tail)
%
function [ci_f, ci_lambda, f_value, p_value, H] = FTest2D(X, Y, alpha, tail)
m = length(X);
n = length(Y);

sigma_2_1 = var(X);
sigma_2_2 = var(Y);

f_value = sigma_2_1 / sigma_2_2;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
      ci_f(1) =  finv(alpha/2, m-1, n-1);
      ci_f(2) =  finv(1 - alpha/2, m-1, n-1);
        
      ci_lambda(1) = (1/sqrt(ci_f(2))) * (sqrt(sigma_2_1)/sqrt(sigma_2_2));
      ci_lambda(2) = (1/sqrt(ci_f(1))) * (sqrt(sigma_2_1)/sqrt(sigma_2_2));
        
      probability = fcdf(f_value, m-1, n-1);
      p_value = 2.0 * min(probability, 1 - probability);
        
    case {'right', 1}
      ci_f(1) =  0;
      ci_f(2) =  finv(1 - alpha, m-1, n-1);
        
      ci_lambda(1) = (1/sqrt(ci_f(2))) * (sqrt(sigma_2_1)/sqrt(sigma_2_2));
      ci_lambda(2) = Inf;
        
      probability = fcdf(f_value, m-1, n-1);
      p_value = 1 - probability;
            
    case {'left', -1}
      ci_f(1) =  finv(alpha, m-1, n-1);
      ci_f(2) =  Inf;
        
      ci_lambda(1) = 0;
      ci_lambda(2) = (1/sqrt(ci_f(1))) * (sqrt(sigma_2_1)/sqrt(sigma_2_2));
        
      probability = fcdf(f_value, m-1, n-1);
      p_value = probability;
end

% make your decision based on confidence intervals, and note that, the 
% condition (sigma_0 > ci_std(1) && sigma_0 < ci_std(2)) would also be correct!
H = ~(f_value > ci_f(1) && f_value < ci_f(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end
