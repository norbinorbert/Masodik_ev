function [megoldas_trapez, megoldas_Simpson] = Trapez_Simpson_integralas(f, a, b, n)
h = (b-a) / n;

x = zeros(n+1);
x(1) = a;
for i = 2:n
   x(i) = x(i-1) + h; 
end
x(n+1) = b;

megoldas_trapez = (h/2) * (f(a) + 2 * sum(f(x(2:n))) + f(b));

megoldas_Simpson = (h/6) * (f(a) + 2*sum(f(x(2:n))) + 4*sum(f((x(1:n) + x(2:n+1))/2)) + f(b));

end