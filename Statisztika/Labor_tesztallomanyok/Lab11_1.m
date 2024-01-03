function Lab11_1
X = [253.36, 248.96, 251.59, 250.15, 252.24, 251.17, 253.63, 248.48, 251.47,...
246.06, 254.44, 244.26, 244.66, 245.95, 235.28, 257.19, 251.63, 246.23,...
250.85, 241.14];
alpha = 0.07;
sigma_0 = 5;

[ci_chi2, ci_std, chi2_value, p_value, H] = Chi2Test(X, sigma_0, alpha, 'left')

if H == 1
   fprintf('A lencse mennyisegenek elmeleti hibaja kisebb, mint 5 gramm\n'); 
else
   fprintf('A lencse mennyisegenek elmeleti hibaja nem kisebb, mint 5 gramm\n'); 
end

end