function [] = Lab1_3(ismetlesek_szama)
%szimulalas visszatevessel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=0;
b1=0;

for i=1:ismetlesek_szama
    kamion=0;
    verseny=0;
    tuzolto=0;
    for j=1:12
        random = UMersenneTwisterRNG;
        if (random < 0.25)
            kamion = kamion + 1;
        else if(random >0.65)
                tuzolto = tuzolto + 1;
            else
                verseny = verseny + 1;
            end;
        end;
    end;
    
    if (kamion==3) && (verseny==5)
        a1 = a1 + 1;
    end;
    
    if(verseny >= 1) && (tuzolto == 3)
        b1 = b1 + 1;
    end;
end;

fprintf('\na) pontosan 3 kamion es 5 versenyauto, visszatevessel: %f\n', a1/ismetlesek_szama)
fprintf('b) legalabb 1 versenyauto es pontosan 3 tuzolto, visszatevessel: %f\n\n', b1/ismetlesek_szama)

%szimulalas visszateves nelkul %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a2=0;
b2=0;

for i=1:ismetlesek_szama
    autok_szama = 20;
    kamion_esely = 5;
    verseny_esely = 8;
    kamion = 0;
    verseny = 0;
    tuzolto = 0;
    
    for j=1:12
        random = UMersenneTwisterRNG;
        if (random < kamion_esely / autok_szama)
            kamion = kamion + 1;
            kamion_esely = kamion_esely - 1;
        else if(random > (kamion_esely + verseny_esely) / autok_szama)
                tuzolto = tuzolto + 1;
            else
                verseny = verseny + 1;
                verseny_esely = verseny_esely - 1;
            end;
        end;
        autok_szama = autok_szama - 1;
    end;
    
    if (kamion==3) && (verseny==5)
        a2 = a2 + 1;
    end;
    
    if(verseny >= 1) && (tuzolto == 3)
        b2 = b2 + 1;
    end;
end;

fprintf('a) pontosan 3 kamion es 5 versenyauto, visszateves nelkul: %f\n', a2/ismetlesek_szama)
fprintf('b) legalabb 1 versenyauto es pontosan 3 tuzolto, visszateves nelkul: %f\n\n', b2/ismetlesek_szama)



