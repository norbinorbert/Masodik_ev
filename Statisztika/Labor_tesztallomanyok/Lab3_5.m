function Lab3_5(ismetlesek_szama)

x = [1 2 3; 20/62 24/62 0];
x(2,3) = 1 - x(2,1) - x(2,2);

kedvezo_esetek = 0;
for i=1:ismetlesek_szama
    lila = 0;
    feher = 0;
    piros = 0;
    for j=1:14
        minta = InversionByBinarySearch(x, 2, 1);
        if minta == 1
            lila = lila + 1;
        end
        if minta == 2
            feher = feher + 1;
        end
        if minta == 3
            piros = piros + 1;
        end
    end
    
    if piros==3 && lila>=2
        kedvezo_esetek = kedvezo_esetek + 1;
    end
end

fprintf('3 piros, legalabb 2 lila, visszatevessel: %f\n', kedvezo_esetek/ismetlesek_szama);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [1 2 3; 0, 0, 0];

atlag = 0;
for i=1:ismetlesek_szama
    feher = 0;
    kivalasztott = 0;
    osszeg = 62;
    maradek_lila = 20;
    maradek_feher = 24;
    while feher ~= 10
        x(2, 1) = maradek_lila/osszeg;
        x(2, 2) = maradek_feher/osszeg;
        x(2, 3) = 1 - x(2,1) - x(2,2);
        minta = InversionByBinarySearch(x, 2, 1);
        if minta == 1
            maradek_lila = maradek_lila - 1;
        end
        if minta == 2
            feher = feher + 1;
            maradek_feher = maradek_feher - 1;
        end
        kivalasztott = kivalasztott + 1;
        osszeg = osszeg - 1;
    end
    atlag = atlag + kivalasztott;
end

fprintf('kivalasztasok szama 10. feher golyoig: %f\n', atlag/ismetlesek_szama);

end