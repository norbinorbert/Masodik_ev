function [maxnorm,norm2]=norma(x)
% a fuggveny az x vektor normajat szamolja
% maxnorm - maximum norma
% norm2-  euklideszi norma
n=length(x);
maxnorm=max(abs(x));
ss=0;
%rovidebben: sqrt(sum(x.^2)) vagy sqrt(x*x')
for i=1:n
ss=ss +x(i) ^ 2;
end;
norm2=sqrt(ss);