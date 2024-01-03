% -----------
% Description
% -----------
% The function performs a one-sample $\Green{\chi^2}$-test of the null hypothesis $\Green{H_0 : \DBlue{\sigma^2} = \Red{\sigma_0^2}}$ that the 
% data in the vector $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$ comes from an $\Green{\mathcal{N}\left(\mu, \DBlue{\sigma}\right)}$ distribution, where the 
% theoretical standard deviation $\Green{\DBlue{\sigma}>0}$ is an unknown parameter.
%
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$         - an independent and identically distributed sample of the normal 
%              distribution $\Green{\mathcal{N}\left(\mu, \DBlue{\sigma}\right)}$, where the theoretical standard deviation $\Green{\DBlue{\sigma}>0}$
%              is unknown
% sigma_0    - denotes the guess $\Red{\sigma_0}$ of the user for the unknown theoretical standard 
%              deviation $\DBlue{\sigma}$
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines   
%              the type of the alternative hypothesis)
%

% ------
% Output
% ------
% ci_chi2    - confidence interval for the random variable $\Green{V_n = \displaystyle\frac{\left(n-1\right)\overline{\sigma}^2}{\DBlue{\sigma}^2}}$
% ci_std     - confidence interval for standard deviation $\DBlue{\sigma}$
% chi2_value - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\sigma^2} = \Red{\sigma_0^2}}$ is true
% p_value    - probability of observing the given result, or one more extreme, by  
%              chance if the null hypothesis $\Green{H_0 : \DBlue{\sigma^2} = \Red{\sigma_0^2}}$ is true (small $\Blue{p}$-values cast 
%              doubt on the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis, 
%              1 = alternative hypothesis defined by the input parameter tail)
%
function [ci_chi2, ci_std, chi2_value, p_value, H] = Chi2Test(X, sigma_0, alpha, tail)

% check the validity of input parameters!
...

% get the size of the sample $\Green{\left\{X_j\right\}_{j=1}^n}$
n = length(X);

% calculate the sample variance $\Green{\overline{\sigma}^2 = \displaystyle\frac{1}{n-1}\displaystyle\sum_{j=1}^n\left(X_j - \overline{X}\right)^2}$
sigma_2_ = var(X);

% calculate the chi2-value $\Red{V_n^0} = \Green{\displaystyle\frac{\left(n-1\right)\overline{\sigma}^2}{\Red{\sigma_0^2}}}$
chi2_value = (n-1) * sigma_2_ / sigma_0^2;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
      % determine the confidence interval $\Green{\left(\DPurple{ \chi^2_{ \frac{\alpha}{2} } } = \DPurple{ F_{\chi^2\left(n-1, 1\right)}^{-1}\left(\frac{\alpha}{2}\right)}, \DPurple{\chi^2_{1-\frac{\alpha}{2}}} = \DPurple{F_{\chi^2\left(n-1,1\right)}^{-1}\left(1-\frac{\alpha}{2}\right)}\right)}$
      ci_chi2(1) =  chi2inv(alpha/2, n-1);
      ci_chi2(2) =  chi2inv(1 - alpha/2, n-1);
        
      % store the end points of the confidence interval $\Green{\left(\overline{\sigma} \sqrt{\displaystyle\frac{n-1}{\DPurple{\chi^2_{1-\frac{\alpha}{2}}}}},\overline{\sigma} \sqrt{\displaystyle\frac{n-1}{\DPurple{\chi^2_{\frac{\alpha}{2}}}}} \right)}$
      ci_std(1) = sqrt((n - 1) * sigma_2_ / ci_chi2(2));
      ci_std(2) = sqrt((n - 1) * sigma_2_ / ci_chi2(1));
        
        % calculate the p-value $\Blue{p}\,\Green{ = 2 \min\left\{F_{\chi^2\left(n-1, 1\right)}\left( \Red{V_n^0}  \right), 1 - F_{\chi^2\left(n-1, 1\right)}\left( \Red{V_n^0}  \right)\right\}}$
      probability = chi2cdf(chi2_value, n-1);
      p_value = 2.0 * min(probability, 1 - probability);
        
    case {'right', 1}
      ci_chi2(1) =  0;
      ci_chi2(2) =  chi2inv(1 - alpha, n-1);
        
      ci_std(1) = sqrt((n - 1) * sigma_2_ / ci_chi2(2));
      ci_std(2) = Inf;
        
      probability = chi2cdf(chi2_value, n-1);
      p_value = 1 - probability;
            
    case {'left', -1}
      ci_chi2(1) =  chi2inv(alpha, n-1);
      ci_chi2(2) =  Inf;
        
      ci_std(1) = 0;
      ci_std(2) = sqrt((n - 1) * sigma_2_ / ci_chi2(1));
        
      probability = chi2cdf(chi2_value, n-1);
      p_value = probability;
end

% make your decision based on confidence intervals, and note that, the 
% condition (sigma_0 > ci_std(1) && sigma_0 < ci_std(2)) would also be correct!
H = ~(chi2_value > ci_chi2(1) && chi2_value < ci_chi2(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end