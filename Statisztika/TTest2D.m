% -----------
% Description
% -----------
% The function performs a two-sample $\Green{T}$-test of the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ that the 
% data in the two independent samples $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$ and $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$, of random variables 
% $\Green{X\sim\mathcal{N}\left(\DBlue{\mu_1},\DBlue{\sigma_1}\right)}$ and $\Green{Y\sim\mathcal{N}\left(\DBlue{\mu_2},\DBlue{\sigma_2}\right)}$, come from distributions with equal theoretical means
% with unknown (and not necessarily equal) theoretical standard deviations.
%
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_i\right\}_{i=1}^m}$         - an independent and identically distributed sample of the normal 
%              distribution $\Green{\mathcal{N}\left(\DBlue{\mu_1},\DBlue{\sigma_1}\right)}$, where both parameters $\Green{\DBlue{\mu_1}\in\mathbb{R}}$ and $\Green{\DBlue{\sigma_1}>0}$
%              are unknown
% $\Green{\mathbf{Y}=\left\{Y_j\right\}_{j=1}^n}$         - an independent and identically distributed sample of the normal 
%              distribution $\Green{\mathcal{N}\left(\DBlue{\mu_2},\DBlue{\sigma_2}\right)}$, where both parameters $\Green{\DBlue{\mu_2}\in\mathbb{R}}$ and $\Green{\DBlue{\sigma_2}>0}$
%              are unknown
% equal_std  - a boolean variable which specifies whether the unknown standard  
%              deviations $\Green{\DBlue{\sigma_1}}$ and $\Green{\DBlue{\sigma_2}}$ are equal
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines  
%              the type of the alternative hypothesis)
%
% ------
% Output
% ------
% ci_t       - confidence interval for the random variable 
%
%              $\Green{T_{m,n} = \left\{ \begin{array}{rl} \frac{ \left(\overline{X} - \overline{Y}\right) - \left(\DBlue{\mu_1} - \DBlue{\mu_2}\right)}{ \sqrt{\left(m-1\right)\overline{\sigma}_1^2 + \left(n-1\right) \overline{\sigma}_2^2}} \cdot \sqrt{\frac{m+n-2}{\frac{1}{m} + \frac{1}{n}}},& \DBlue{\sigma_1} = \DBlue{\sigma_2},\\ \\ \frac{ \left(\overline{X} - \overline{Y}\right) - \left(\DBlue{\mu_1} - \DBlue{\mu_2}\right)}{ \sqrt{\frac{\overline{\sigma}_1^2}{m} + \frac{ \overline{\sigma}_2^2}{n}}},& \DBlue{\sigma_1} \neq \DBlue{\sigma_2} \end{array}  \right.}$
%
% ci_delta   - confidence interval for the difference $\Green{\DBlue{\delta} = \DBlue{\mu_1} - \DBlue{\mu_2}}$ of the theoretical 
%              mean values
% t_value    - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ is true
% p_value    - probability of observing the given result, or one more extreme, by chance 
%              if the null hypothesis $\Green{H_0 : \DBlue{\mu_1} = \DBlue{\mu_2}}$ is true (small $\Blue{p}$-values cast doubt on
%              the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis, 1 = alternative 
%              hypothesis defined by the input parameter tail)
%
function [ci_t, ci_delta, t_value, p_value, H] = TTest2D(X, Y, equal_std, alpha, tail)

% check the validity of input parameters!
...

% get the size of the given samples $\Green{\left\{X_i\right\}_{i=1}^m}$ and $\Green{\left\{Y_j\right\}_{j=1}^n}$
m = length(X);
n = length(Y);

% calculate the constant $\Green{ s = \left\{\begin{array}{rl}\sqrt{ \left( \left(m-1\right) \overline{\sigma}_1^2 + \left(n-1\right)\overline{\sigma}_2^2 \right) \cdot \displaystyle\frac{m + n}{mn\left(m+n-2\right)}}, &\DBlue{\sigma_1} = \DBlue{\sigma_2},\\ \\ \sqrt{\displaystyle\frac{\overline{\sigma}_1^2}{m} + \displaystyle\frac{ \overline{\sigma}_2^2}{n}},&\DBlue{\sigma_1} \neq \DBlue{\sigma_2} \end{array} \right. }$
sigma_1_2_ = var(X);
sigma_2_2_ = var(Y);

if (equal_std)
    s = sqrt(((m-1) * sigma_1_2_ + (n-1) * sigma_2_2_) * (m + n) / m / n / (m + n - 2));
else
    s = sqrt(sigma_1_2_ / m + sigma_2_2_ / n);
end

% determine the degree of freedom $\Green{ \eta = \left\{\begin{array}{rl}m + n - 2, &\DBlue{\sigma_1} = \DBlue{\sigma_2} = \DBlue{\sigma},\\ \\ \displaystyle\frac{\left(m-1\right)\left(n-1\right)}{\left(m-1\right)\left(1-w\right)^2 + \left(n-1\right) w^2},& \DBlue{\sigma_1} \neq \DBlue{\sigma_2},\end{array}\right.  }$
% where $\Green{w  = \displaystyle\frac{n \overline{\sigma}_1^2}{n \overline{\sigma}_1^2 + m\overline{\sigma}_2^2}}$
if (equal_std)
    eta = m + n - 2;
else
    w = n * sigma_1_2_ / (n * sigma_1_2_ + m * sigma_2_2_);
    eta = (m - 1) * (n - 1) / ((m - 1) * (1 - w)^2 + (n - 1) * w^2);
end

% calculate the difference $\Green{\overline{X}-\overline{Y} = \displaystyle\frac{1}{m}\displaystyle\sum_{i=1}^m X_i - \displaystyle\frac{1}{n}\displaystyle\sum_{j=1}^n Y_j}$ of sample means 
X_Y_ = mean(X) - mean(Y);

% calculate the t-value $\Red{T_{m,n}^0} = \Green{  \displaystyle\frac{  \overline{X} -\overline{Y} }{ s }}$
t_value = X_Y_ / s;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
        % calculate the inverse function value $\Green{\DPurple{t_{1-\frac{\alpha}{2}}} = \DPurple{F_{\mathcal{S}\left(\eta\right)}^{-1}\left(1-\frac{\alpha}{2}\right)}}$
        t = tinv(1 - alpha / 2, eta);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-t_{1-\frac{\alpha}{2}}}, \DPurple{+t_{1-\frac{\alpha}{2}}}\right)}$
        ci_t(1) = -t;
        ci_t(2) =  t;
        
        % store the end points of the confidence interval 
        % $\Green{\left(\overline{X} - \overline{Y} - s \cdot \DPurple{t_{1-\frac{\alpha}{2}}},\overline{X} - \overline{Y} + s \cdot \DPurple{t_{1-\frac{\alpha}{2}}}\right)}$
        ci_delta(1) = X_Y_ - s * t;
        ci_delta(2) = X_Y_ + s * t;
        
        % calculate the p-value $\Blue{p}\,\Green{ = 2 F_{\mathcal{S}\left(\eta\right)} \left( -\left| \Red{T_{m,n}^0} \right|\right)}$
        p_value = 2.0 * tcdf(-abs(t_value), eta);
        
    case {'right', 1}
        t = tinv(1 - alpha, eta);
        
        ci_t(1) = -Inf;
        ci_t(2) =  t;
        
        ci_delta(1) = X_Y_ - s * t;
        ci_delta(2) = Inf;
        
        p_value = 1 - tcdf(t_value, eta);
        
    case {'left', -1}
        t = tinv(alpha, eta);
        
        ci_t(1) = t;
        ci_t(2) = Inf;
        
        ci_delta(1) = -Inf;
        ci_delta(2) = X_Y_ - s * t;
        
        p_value = tcdf(t_value, eta);
        
end

% make your decision based on confidence intervals, and note that, the 
% condition ($\Red{0}$ > ci_delta(1) && $\Red{0}$ < ci_delta(2)) would also be correct!
H = ~(t_value > ci_t(1) && t_value < ci_t(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end