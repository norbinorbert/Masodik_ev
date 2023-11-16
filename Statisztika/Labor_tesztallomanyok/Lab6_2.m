function Lab6_2
f = @(x,y) 1/25.*((1/2.*y.^2)-y.^4.*(1/16-x.^2)+1/2);

M = f(-2,2);
X = Elutasitas_modszere_ketvaltozos(f, M, [-2,1], [0,2], 10000);
hist3(X);

figure;
plot(X(:,1), X(:,2), '.');

figure;
plot3(X(:,1),X(:,2),f(X(:,1), X(:,2)), '.');

x = [-2:0.025:1];
y = [0:0.025:2];
[xx,yy] = meshgrid(x,y);
figure;
surf(xx, yy, f(xx,yy));

end