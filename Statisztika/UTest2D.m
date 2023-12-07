% -----------
% Description
% -----------
% The function performs a two-sample $\Green{U}$-test of the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ that the 
% data in the two independent samples $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$ and $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$, of random variables 
% $\Green{X\sim\mathcal{N}\left(\DBlue{\mu_1},\sigma_1\right)}$ and $\Green{Y\sim\mathcal{N}\left(\DBlue{\mu_2},\sigma_2\right)}$, come from distributions with equal theoretical means.
% 
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$         - an independent and identically distributed sample of the normal
%              distribution $\Green{\mathcal{N}\left(\DBlue{\mu_1},\sigma_1\right)}$, where only the theoretical mean value $\Green{\DBlue{\mu_1}\in\mathbb{R}}$ is 
%              unknown
% $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$         - an independent and identically distributed sample of the normal
%              distribution $\Green{\mathcal{N}\left(\DBlue{\mu_2},\sigma_2\right)}$, where only the theoretical mean value $\Green{\DBlue{\mu_2}\in\mathbb{R}}$ is
%              unknown
% sigma_1    - corresponds the known value of theoretical standard deviation $\Green{\sigma_1>0}$
% sigma_2    - denotes the known value of theoretical standard deviation $\Green{\sigma_2>0}$
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines  
%              the type of the alternative hypothesis)
%
% ------
% Output
% ------
% ci_u       - confidence interval for the random variable 
%
%              $\Green{U_{m,n} = \displaystyle\frac{\left(\overline{X}-\overline{Y}\right) - \left(\DBlue{\mu_1}-\DBlue{\mu_2}\right)}{\sqrt{\frac{\sigma_1^2}{m} + \frac{\sigma_2^2}{n}}}\sim\mathcal{N}\left(0,1\right)}$
%
% ci_delta   - confidence interval for the difference $\Green{\DBlue{\delta} = \DBlue{\mu_1} - \DBlue{\mu_2}}$ of the theoretical
%              mean values
% u_value    - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ is true
% p_value    - probability of observing the given result, or one more extreme, by  
%              chance if the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ is true (small $\Blue{p}$-values  
%              cast doubt on the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis, 
%               1 = alternative hypothesis defined by the input parameter tail)
%
function [ci_u, ci_delta, u_value, p_value, H] = UTest2D(...
    X, Y, sigma_1, sigma_2, alpha, tail)

% check the validity of input parameters!
...

% get the size of the given samples $\Green{\left\{X_i\right\}_{i=1}^m}$ and $\Green{\left\{Y_j\right\}_{j=1}^n}$
m = length(X);
n = length(Y);

% observe that $\Green{ \sqrt{ \frac{ \sigma_1^2 }{m} + \frac{\sigma_2^2}{n} } }$ is a constant
s = sqrt(sigma_1^2 / m + sigma_2^2 / n);

% calculate the difference $\Green{\overline{X}-\overline{Y} = \displaystyle\frac{1}{m}\displaystyle\sum_{i=1}^m X_i - \displaystyle\frac{1}{n}\displaystyle\sum_{j=1}^n Y_j}$ of sample means 
X_Y_ = mean(X) - mean(Y);

% calculate the u-value $\Red{U_{m,n}^0} = \Green{  \displaystyle\frac{  \overline{X} -\overline{Y} }{ \sqrt{\frac{\sigma_1^2}{m} + \frac{\sigma_2^2}{n} }}}$
u_value = X_Y_ / s;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
        % calculate the inverse function value $\Green{\DPurple{u_{1-\frac{\alpha}{2}}} = \DPurple{F_{\mathcal{N}\left(0,1\right)}^{-1}\left(1-\frac{\alpha}{2}\right)}}$
        u = norminv(1 - alpha / 2, 0, 1);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-u_{1-\frac{\alpha}{2}}}, \DPurple{+u_{1-\frac{\alpha}{2}}}\right)}$
        ci_u(1) = -u;
        ci_u(2) =  u;
        
        % store the end points of the confidence interval 
        % $\Green{\left(\overline{X} - \overline{Y} - \sqrt{\frac{\sigma_1^2}{m} + \frac{\sigma_2^2}{n}} \cdot \DPurple{u_{1-\frac{\alpha}{2}}}, \overline{X} - \overline{Y} + \sqrt{\frac{\sigma_1^2}{m} + \frac{\sigma_2^2}{n}} \cdot \DPurple{u_{1-\frac{\alpha}{2}}}\right)}$
        ci_delta(1) = X_Y_ - s * u;
        ci_delta(2) = X_Y_ + s * u;
        
        % calculate the p-value $\Blue{p}\,\Green{ = 2 F_{\mathcal{N}\left(0,1\right)} \left( -\left| \Red{U_{m,n}^0} \right|\right)}$
        p_value = 2.0 * normcdf(-abs(u_value), 0, 1);
        
    case {'right', 1}
        u = norminv(1 - alpha, 0, 1);
        
        ci_u(1) = -Inf;
        ci_u(2) = u;
        
        ci_delta(1) = X_Y_ - s * u;
        ci_delta(2) = Inf;
        
        p_value = 1 - normcdf(u_value, 0, 1);
    case {'left', -1}
        u = norminv(alpha, 0, 1);
        
        ci_u(1) = u;
        ci_u(2) = Inf;
        
        ci_delta(1) = -Inf;
        ci_delta(2) = X_Y_ - s * u;
        
        p_value = normcdf(u_value, 0, 1);
end

% make your decision based on confidence intervals, and note that, the 
% condition ($\Red{0}$ > ci_delta(1) && $\Red{0}$ < ci_delta(2)) would also be correct!
H = ~(u_value > ci_u(1) && u_value < ci_u(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end