function [eredmeny] = dominans_foatlo(A)
n = size(A,1);
m = size(A,2);
if (n~=m)
    error('Nem negyzetes matrix');
end;

eredmeny = true;

for i=1:n
    osszeg = sum(abs(A(i,1:i-1))) + sum(abs(A(i,i+1:n)));
    if(osszeg >= abs(A(i,i)))
        eredmeny = false;
        break;
    end;
end;