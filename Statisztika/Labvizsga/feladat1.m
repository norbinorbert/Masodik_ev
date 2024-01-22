%Boda Norbert, bnim2219
function feladat1
X = [197.1, 201.6, 198.9, 201.2, 202.1, 198.3, 197.7, 195.8, 199.5, 203.3, 203.6, 203.9, 202.4];
Y = [201.7, 200.1, 202.4, 201.6, 202.9, 198.4, 206.1, 201.9, 204.1, 200.3, 197.6, 199.8];

alpha = 0.07;
mu_0 = 200;
[ci_t, ci_mu, t_value, p_value, H] = TTest(Y, mu_0, alpha, 'right')

if H == 1
   fprintf('A masodik gep atlagosan tobb gyumolcsot adagol, mint az eloirt 200 gramm'); 
else
   fprintf('A masodik gep atlagosan nem adagol tobb gyumolcsot, mint az eloirt 200 gramm');
end

alpha = 0.03;
[ci_f, ci_lambda, f_value, p_value, H] = FTest2D(X, Y, alpha, 'left')

if H == 1
   fprintf('Az elso gep kisebb adagolasi hibaval dolgozik, mint a masodik gep'); 
else
   fprintf('Az elso gep nem dolgozik kisebb adagolasi hibaval, mint a masodik gep');
end

end