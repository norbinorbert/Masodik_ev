function X = Hur_modszer(F, n, delta, A, B)
X = zeros(1,n);
FA = F(A);
FB = F(B);
for i=1:n
    U = URealRNG(0, 4, FA, FB, 1);
    a = A;
    b = B;
    while true
        Fa = F(a);
        Fb = F(b);
        seged = a + (b-a) * ((U-Fa)/(Fb - Fa));
        Fs = F(seged);
        if Fs <= U
            a = seged;
        else
            b = seged;
        end
        if (b-a <= 2*delta) || (abs(U - Fs) < delta)
            break;
        end
    end
    X(i) = seged;
end

end