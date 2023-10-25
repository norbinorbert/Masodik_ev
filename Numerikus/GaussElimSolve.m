function GaussElimSolve(A,b)
[U,c] = GaussElim(A, b);
n = length(A);
R = rank(A);
if R == n
    x = UTriangSolve(U, c)
else
    for i=R+1:n
        if(c(i, 1) > eps)
            error('Inkompatibilis a rendszer');
        end
    end
    fprintf('A rendszer kompatibilis, hatarozatlan\n');
end


end

