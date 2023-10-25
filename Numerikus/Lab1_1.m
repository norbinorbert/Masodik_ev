function [] = Lab1_1(x, epsz)
%%%%%%%%%%%%%%%% sin %%%%%%%%%%%%%%%%%%%%%%%
    eredeti = x;
    x = mod(x, 2*pi);
    sin = x;
    elozo = x;
    n = 1;
    kovetkezo = elozo * (x*x)/(2*n*(2*n+1));
    while(kovetkezo > epsz)
        if(mod(n,2) == 1)
            sin = sin - kovetkezo;
        else
            sin = sin + kovetkezo;
        end
        n = n + 1;
        elozo = kovetkezo;
        kovetkezo = elozo * (x*x)/(2*n*(2*n+1));
    end
    
    fprintf('sin(%f) = %f\n', eredeti, sin);
    
%%%%%%%%%%%%%%%% cos %%%%%%%%%%%%%%%%%%%%%%%

    cos = 1;
    elozo = 1;
    n = 0;
    kovetkezo = elozo * (x*x) / ((2*n+1)*(2*n+2));
    while(kovetkezo > epsz)
        if(mod(n,2) == 0)
            cos = cos - kovetkezo;
        else
            cos = cos + kovetkezo;
        end
        n = n + 1 ;
        elozo = kovetkezo;
        kovetkezo = elozo * (x*x) / ((2*n+1)*(2*n+2));
    end
    
    fprintf('cos(%f) = %f\n', eredeti, cos);
end