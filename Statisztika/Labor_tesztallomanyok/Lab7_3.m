function Lab7_3(n)

kiadott = zeros(1,n);
for i=1:n
    elso = [1, 2; 1/2, 1/2];
    masodik = [1, 2; 1/3, 2/3];
    harmadik = [1, 2; 1/6, 5/6];
    emelet = [1, 2, 3; 1/6, 1/6, 4/6];
    
    elso_szobak = 12;
    elso_ketagyas = 6;
    
    masodik_szobak = 12;
    masodik_ketagyas = 8;
    
    harmadik_szobak = 12;
    harmadik_ketagyas = 10;
    
    kiadott_ketagyas = 0;
    while kiadott_ketagyas ~= 7
        if elso_szobak == 0
            emelet = [1, 2, 3; 0, 2/6, 4/6];
        end
        if masodik_szobak == 0
            emelet = [1, 2, 3; 2/6, 0, 4/6];
        end
        if harmadik_szobak == 0
            emelet = [1, 2, 3; 1/2, 1/2, 0];
        end
        if harmadik_szobak == 0 && masodik_szobak == 0
            emelet = [1, 2, 3; 1, 0, 0];
        end
        switch InversionBySequentialSearch(emelet, 2, 1);
            case 1
                if InversionBySequentialSearch(elso, 2, 1) == 2
                    kiadott_ketagyas = kiadott_ketagyas + 1;
                    elso_ketagyas = elso_ketagyas - 1;
                end
                elso_szobak = elso_szobak - 1;
                elso = [1, 2; 0, elso_ketagyas/elso_szobak];
                elso(2, 1) = 1 - elso(2, 2);
            case 2
                if InversionBySequentialSearch(masodik, 2, 1) == 2
                    kiadott_ketagyas = kiadott_ketagyas + 1;
                    masodik_ketagyas = masodik_ketagyas - 1;
                end
                masodik_szobak = masodik_szobak - 1;
                masodik = [1, 2; 0, masodik_ketagyas/masodik_szobak];
                masodik(2, 1) = 1 - masodik(2, 2);
            case 3
                if InversionBySequentialSearch(harmadik, 2, 1) == 2
                    kiadott_ketagyas = kiadott_ketagyas + 1;
                    harmadik_ketagyas = harmadik_ketagyas - 1;
                end
                harmadik_szobak = harmadik_szobak - 1;
                harmadik = [1, 2; 0, harmadik_ketagyas/harmadik_szobak];
                harmadik(2, 1) = 1 - harmadik(2, 2);
        end
        kiadott(i) = kiadott(i) + 1;
    end
end
fprintf('varhatoan %f szobat kell kiadni a hetedik ketagyas szoba kiadasaig\n', mean(kiadott));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
emelet = [1, 2, 3; 1/6, 1/6, 4/6];

elso = [1, 2; 1/2, 1/2];
masodik = [1, 2; 1/3, 2/3];

egyagyas_szobak = zeros(1, n);
for i=1:n
    for j=1:15
        switch InversionBySequentialSearch(emelet, 2, 1);
            case 1
                if InversionBySequentialSearch(elso, 2, 1) == 1
                    egyagyas_szobak(i) = egyagyas_szobak(i) + 1;
                end
            case 2
                if InversionBySequentialSearch(masodik, 2, 1) == 1
                    egyagyas_szobak(i) = egyagyas_szobak(i) + 1;
                end
        end
    end
end
fprintf('elso es masodik emeleti egyagyas szobak varhato erteke: %f\n', mean(egyagyas_szobak));
end