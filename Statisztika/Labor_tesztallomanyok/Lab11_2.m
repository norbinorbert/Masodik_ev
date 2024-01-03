function Lab11_2
X = [499, 501, 500, 502, 498, 497, 499, 501, 500, 500, 503, 501, 500, 503, 498, 501];
Y = [502, 497, 500, 497, 498, 500, 501, 499, 499, 501, 500, 496, 499, 496];
alpha = 0.01;

[ci_f, ci_lambda, f_value, p_value, H] = FTest2D(X, Y, alpha, 'both')

if H == 1
    fprintf('A mososzeradalek elmeleti szorasa kulonbozik\n');
    equal_std = 0;
else
    fprintf('A mososzeradalek elmeleti szorasa nem kulonbozik\n');
    equal_std = 1;
end

alpha = 0.07;
[ci_t, ci_delta, t_value, p_value, H] = TTest2D(X, Y, equal_std, alpha, 'left')

if H == 1
    fprintf('A masodik gep atlagosan tobb mososzeradalekot tolt, mint az elso\n');
else
    fprintf('A masodik gep atlagosan nem tolt tobb mososzeradalekot, mint az elso\n');
end

end