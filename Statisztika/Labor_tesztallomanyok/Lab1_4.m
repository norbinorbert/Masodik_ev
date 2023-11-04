function [] = Lab1_4(ismetlesek_szama)

%szukseges egyenesek, illetve gorbek egyenlete
%hatszogon belul legyen
BC = @(x,y) 3/2*(x-8) + y;
CD = @(x,y) x - y - 8;
DE = @(x,y) 1/4*(x-4) + y + 4;
EF = @(x,y) 5/4*(x+4) + y + 2;
AF = @(x,y) 3/5*(x+3) - y + 6;

%DFGH negyszogon belul legyen
DF = @(x,y) 7/12*(x-4) + y + 4;

%BE felett es koron kivul
BE = @(x,y) x - y + 2;
kor = @(x,y) x^2 + (y-2)^2 - 16;

%a) alpont %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1);
belseje = 0;
for i=1:ismetlesek_szama
    new_x=0;
    new_y=0;
    %random pont generalasa amig a hatszogon belul lesz
    while 1
        x = URealRNG(1, 4, -8, 8, 1);
        y = URealRNG(1, 4, -4, 6, 1);
        
        if(BC(x,y) > 0) || (CD(x,y) > 0) || (DE(x,y) < 0) || (EF(x,y) < 0) || (AF(x,y) < 0)
            continue;
        end;
        new_x = x;
        new_y = y;
        break;
    end;
    
    %DFGH negyszogon beluli pontok ellenorzese es abrazolasa
    if(DF(new_x, new_y) < 0) || (new_y > 3) || (new_x > 6)
        plot(new_x, new_y, 'b.');
    else
        belseje = belseje + 1;
        plot(new_x, new_y, 'r.');
    end;
    hold on;
end;
fprintf('a) a DFGH negyszog belsejeben helyezkedik el: %f\n', belseje / ismetlesek_szama);

%b) alpont %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,2);
belseje = 0;
for i=1:ismetlesek_szama
    new_x=0;
    new_y=0;
    %random pont generalasa amig a hatszogon belul lesz
    while 1
        x = URealRNG(1, 4, -8, 8, 1);
        y = URealRNG(1, 4, -4, 6, 1);
        
        if(BC(x,y) > 0) || (CD(x,y) > 0) || (DE(x,y) < 0) || (EF(x,y) < 0) || (AF(x,y) < 0)
            continue;
        end;
        new_x = x;
        new_y = y;
        break;
    end;
    
    if(BE(new_x, new_y) > 0) || (kor(new_x,new_y)<0)
        plot(new_x, new_y, 'b.');
    else
        belseje = belseje + 1;
        plot(new_x, new_y, 'r.');
    end;
    hold on;
end;

fprintf('b) a BE szakasz felett es a koron kivul helyezkedik el: %f\n', belseje / ismetlesek_szama);


