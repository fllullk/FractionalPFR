maxd = 1;
mind = -1;
nd = 100;

n = 1;

x = linspace(0,2,1000);
y = x .^ n;

figure(1)

hold on
plot(x,y)

for alpha = linspace(mind, maxd, nd)
    y = gamma(n + 1) / gamma(n - alpha + 1) * x .^ (n - alpha);
    plot(x,y)
end

grid on

hold off
