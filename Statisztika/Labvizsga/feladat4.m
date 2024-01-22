%Boda Norbert, bnim2219
function feladat4
CD = @(x,y) 2*x - 14 - y;
DE = @(x,y) 1.5*x + y;
kor = @(x,y) (x+2)^2 + (y-6)^2 - 16;
CE = @(x,y) 0.6*x - y;

pontok = 0;
kedvezo_a = 0;
while pontok < 10000
    while true
        X = URealRNG(0, 4, -6, 10, 1);
        Y = URealRNG(0, 4, -6, 6, 1);
        if CD(X,Y) > 0 || (DE(X,Y) < 0 && Y<0)
            continue;
        else
            break;
        end
    end
    if kor(X,Y) > 0 && CE(X,Y) < 0
        kedvezo_a = kedvezo_a + 1;
        %plot(X,Y,'b*');
    else
        %plot(X,Y,'r*');
    end
    %hold on
    
    pontok = pontok + 1;
end

kedvezo_a / pontok

FG = @(x,y) 1.2*x + y - 8.4;
GH = @(x,y) 0.6*x - y - 4.2;
EI = @(x,y) 3*x + y;

%figure
kedvezo = 0;
ismetlesek = 10000;
for i = 1:ismetlesek
    pontok = 0;
    kedvezo_b = 0;
    while pontok < 24
        while true
            X = URealRNG(0, 4, -6, 10, 1);
            Y = URealRNG(0, 4, -6, 6, 1);
            if CD(X,Y) > 0 || (DE(X,Y) < 0 && Y<0)
                continue;
            else
                break;
            end
        end
        if EI(X,Y) < 0 || (X>2 && FG(X,Y) < 0 && GH(X,Y) < 0)
            kedvezo_b = kedvezo_b + 1;
            %plot(X,Y,'b*');
        else
            %plot(X,Y,'r*');
        end
        %hold on
        
        pontok = pontok + 1;
    end
    if(kedvezo_b >= 11)
        kedvezo = kedvezo + 1;
    end
end
kedvezo / ismetlesek
end