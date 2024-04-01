N = 101;
x0 = 0;
xf = 1;
t0 = 0;
tf = 10;
nt = 201;
Pe = 25;
DaI = 0;
n = 1;

alphas = linspace(0, 2, 11);

tlegend = cell(size(alphas));

for i = 1:length(alphas)
    
    tlegend{i} = ['\alpha = ', num2str(alphas(i)), ''];

end

[x, t, C] = pfr_fun(N, x0, xf, t0, tf, nt, Pe, DaI, n);

grid on
hold on

for alpha = alphas

[fx, ft, fC] = fpfr_fun(N, x0, xf, t0, tf, nt, Pe, DaI, n, alpha, 1, 1);

plot(t, fC(:, end)-C(:, end))

end

legend(tlegend, 'Location', 'southeastoutside')
