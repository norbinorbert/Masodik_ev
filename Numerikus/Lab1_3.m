function [] = Lab1_3
matrix = [10,7,8,7; 7,5,6,5; 8,6,10,9; 7,5,9,10];
szabadtag = [32;23;33;31];

Inverz = inv(matrix)

Determinans = det(matrix)

megoldas = matrix \ szabadtag

pszabadtag = [32.1; 22.9; 33.1; 30.9];
pmatrix = [10,7,8.1,7.2; 7.08,5.04,6,5; 8,5.98,9.89,9; 6.99,4.99,9,9.89];

megoldas_perturbalt_szabadtaggal = matrix \ pszabadtag

megoldas_perturbalt_egyutthatok = pmatrix \ szabadtag

bemeneti_hiba1 = norm(szabadtag - pszabadtag, Inf) / norm(szabadtag, Inf)
kimeneti_hiba1 = norm(megoldas - megoldas_perturbalt_szabadtaggal, Inf) / norm(megoldas, Inf)

bemeneti_hiba2 = norm(matrix - pmatrix, Inf) / norm(matrix, Inf)
kimeneti_hiba2 = norm(megoldas - megoldas_perturbalt_egyutthatok, Inf) / norm(megoldas, Inf)

kondicio = cond(matrix, Inf)
end