function Lab10_2
X = [197.21, 200.92, 200.53, 200.11, 197.65, 202.0, 200.60, 199.53,...
200.10, 199.55, 196.81, 199.58, 198.56, 198.25, 197.90, 199.02,...
196.45, 201.70];

alfa = 0.06;
mu_0 = 200;
[ci_t, ci_mu, t_value, p_value, H] = TTest(X, mu_0, alfa, 'right')

if H == 0
    fprintf('A gep atlagosan nem adagol tobb italport, mint az eloirt 200 gramos ertek\n');
else
    fprintf('A gep atlagosan tobb italport adagol, mint az eloirt 200 gramos ertek\n'); 
end

X = [28.4, 27.0, 30.8, 27.8, 30.1, 31.2, 30.6, 31.1, 31.8, 27.4, 30.5,...
28.3, 27.6, 30.7, 30.0];
Y = [29.9, 31.9, 31.2, 30.7, 32.6, 32.3, 30.5, 28.6, 28.6, 32.5, 27.6,...
29.9, 28.9, 31.1, 31.8, 30.6, 29.9];

alfa = 0.09;
[ci_t, ci_delta, t_value, p_value, H] = TTest2D(X, Y, 0, alfa, 'left')

if H == 0
    fprintf('A masodik toltogep atlagosan nem tolt tobb arcgeneralo szerumot az uvegcsekbe\n');
else
    fprintf('A masodik toltogep atlagosan tobb arcgeneralo szerumot tolt az uvegcsekbe\n');
end


end