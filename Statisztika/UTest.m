% -----------
% Description
% -----------
% The function performs a one-sample $\Green{U}$-test(*@\footnote{\textbf{test} \emph{próba}; \textbf{left-tailed $\sim$} \emph{bal oldali próba}; \textbf{one-sample $\sim$} \emph{egymintás próba}; \textbf{right-tailed $\sim$} \emph{jobb oldali próba}; \textbf{statistical $\sim$} \emph{statisztikai próba}; \textbf{two-sample $\sim$} \emph{kétmintás próba}; \textbf{two-tailed $\sim$} \emph{kétoldali próba}}@*) of the null hypothesis(*@\footnote{\textbf{hypothesis} \emph{hipotézis}; \textbf{alternative $\sim$} \emph{alternatív hipotézis}; \textbf{null $\sim$} \emph{nullhipotézis}}@*) $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ that the
% data in the vector $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$ comes from an $\Green{\mathcal{N}\left(\DBlue{\mu},\sigma\right)}$ distribution, where the 
% theoretical mean value $\Green{\DBlue{\mu}\in\mathbb{R}}$ is unknown and the theoretical standard deviation $\Green{\sigma>0}$ 
% is a known parameter.
%
% The test is performed against the alternative hypothesis specified by the input  
% parameter tail.
%
% -----
% Input
% -----
% $\Green{\mathbf{X}=\left\{X_j\right\}_{j=1}^n}$         - an independent(*@\footnote{\textbf{independent} \emph{független}; \textbf{$\sim$ random variables} \emph{független valószín\H{u}ségi változók}}@*) and identically distributed(*@\footnote{\textbf{identically distributed} \emph{azonos eloszlású}; \textbf{$\sim$ random variables} \emph{azonos eloszlású valószín\H{u}ségi változók}}@*) sample of the normal  
%              distribution $\Green{\mathcal{N}\left(\DBlue{\mu},\sigma\right)}$, where the theoretical mean value $\Green{\DBlue{\mu}\in\mathbb{R}}$ is unknown
% mu_0       - denotes the guess(*@\footnote{\textbf{guess} \emph{találgatás, feltételezés}}@*) $\Red{\mu_0}$ of the user for the unknown theoretical mean value $\DBlue{\mu}$
% sigma      - stores the known value of theoretical standard deviation $\Green{\sigma>0}$
% alpha      - represents the significance level $\Green{\alpha \in \left(0,1\right)}$
% tail       - a parameter that can be set either by one of the strings 'both',  
%              'right', 'left', or by using one of the numbers 0, 1, -1 (it determines  
%              the type of the alternative hypothesis)
%
% ------
% Output
% ------
% ci_u       - confidence interval(*@\footnote{\textbf{interval} \emph{intervallum}; \textbf{confidence $\sim$} \emph{konfidenciaintervallum, vagy megbízhatósági intervallum}}@*) for the random variable $\Green{U_n = \displaystyle\frac{\overline{X} - \DBlue{\mu}}{\frac{\sigma}{\sqrt{n}}}\sim\mathcal{N}\left(0,1\right)}$
% ci_mu      - confidence interval for theoretical mean value $\DBlue{\mu}$
% u_value    - value of the test, assuming that the null hypothesis $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ is true
% p_value    - probability of observing the given result, or one more extreme, by  
%              chance if the null hypothesis $\Green{H_0 : \DBlue{\mu} = \Red{\mu_0}}$ is true (small $\Blue{p}$-values cast  
%              doubt on the validity of the null hypothesis)
% H          - the code of the accepted hypothesis (0 = null hypothesis,  
%              1 = alternative hypothesis defined by the input parameter tail)
%
function [ci_u, ci_mu, u_value, p_value, H] = UTest(X, mu_0, sigma, alpha, tail)

% check the validity of input parameters!
...

% get the size of the sample $\Green{\left\{X_j\right\}_{j=1}^n}$
n = length(X);

% observe that $\Green{ \displaystyle\frac{\sigma}{\sqrt{n}} }$ is a constant
s = sigma / sqrt(n);

% calculate the sample mean $\Green{\overline{X} = \displaystyle\frac{1}{n}\displaystyle\sum_{j=1}^n X_j}$
X_ = mean(X); % or, equivalently, X_ = sum(X) / n;

% calculate the u-value $\Red{U_n^0} = \Green{\displaystyle\frac{\overline{X} - \Red{\mu_0}}{\frac{\sigma}{\sqrt{n}}}}$
u_value = (X_ - mu_0) / s;

% calculate the confidence intervals
switch (tail)
    case {'both', 0}
        % calculate the inverse function value $\Green{\DPurple{u_{1-\frac{\alpha}{2}}} = \DPurple{F_{\mathcal{N}\left(0,1\right)}^{-1}\left(1-\frac{\alpha}{2}\right)}}$
        u = norminv(1 - alpha / 2, 0, 1);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-u_{1-\frac{\alpha}{2}}}, \DPurple{+u_{1-\frac{\alpha}{2}}}\right)}$
        ci_u(1) = -u;
        ci_u(2) =  u;
        
        % store the end points of the confidence interval $\Green{\left(\overline{X} - \frac{\sigma}{\sqrt{n}} \DPurple{u_{1-\frac{\alpha}{2}}}, \overline{X} + \frac{\sigma}{\sqrt{n}} \DPurple{u_{1-\frac{\alpha}{2}}}\right)}$
        ci_mu(1) = X_ - s * u;
        ci_mu(2) = X_ + s * u;
        
        % calculate the p-value $\Blue{p}\,\Green{ = 2 F_{\mathcal{N}\left(0,1\right)} \left( -\left| \Red{U_n^0} \right|\right)}$
        p_value = 2.0 * normcdf(-abs(u_value), 0, 1);
        
    case {'right', 1}
        % calculate the inverse function value $\Green{\DPurple{u_{1-\alpha}} = \DPurple{F_{\mathcal{N}\left(0,1\right)}^{-1}\left(1-\alpha\right)}}$
        u = norminv(1 - alpha, 0, 1);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-\infty}, \DPurple{u_{1-\alpha}} \right)}$
        ci_u(1) = -inf;
        ci_u(2) =  u;
        
        % store the end points of the confidence interval $\Green{\left( \overline{X} - \frac{\sigma}{\sqrt{n}} \DPurple{u_{1-\alpha}}, \DPurple{+\infty}\right)}$
        ci_mu(1) = X_ - s * u;
        ci_mu(2) = inf;
        
        % calculate the p-value $\Blue{p}\,\Green{ = 1 - F_{\mathcal{N}\left(0,1\right)} \left( \Red{U_n^0} \right)}$
        p_value = 1.0 - normcdf(u_value, 0, 1);
            
    case {'left', -1}
        % calculate the inverse function value $\Green{\DPurple{u_{\alpha}} = \DPurple{F_{\mathcal{N}\left(0,1\right)}^{-1}\left(\alpha\right)}}$
        u = norminv(alpha, 0, 1);
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{u_{\alpha}}, \DPurple{+\infty} \right)}$
        ci_u(1) = u;
        ci_u(2) = inf;
        
        % store the end points of the confidence interval $\Green{\left(\DPurple{-\infty}, \overline{X} - \frac{\sigma}{\sqrt{n}} \DPurple{u_{\alpha}} \right)}$
        ci_mu(1) = -inf;
        ci_mu(2) = X_ - s * u;
        
        % calculate the p-value $\Blue{p}\,\Green{ = F_{\mathcal{N}\left(0,1\right)} \left( \Red{U_n^0} \right)}$
        p_value = normcdf(u_value, 0, 1);        
end

% make your decision based on confidence intervals, and note that, the 
% condition (mu_0 > ci_mu(1) && mu_0 < ci_mu(2)) would also be correct!
H = ~(u_value > ci_u(1) && u_value < ci_u(2));

% do you have any doubt? -- if yes, then apply the corresponding significance test!
if (p_value < alpha)
    disp('Warning: small p-value cast doubt on the validity of the null-hypothesis!');
end