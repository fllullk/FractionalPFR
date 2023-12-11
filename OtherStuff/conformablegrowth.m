% Analytic solutions to fractional Malthus model
% dX/dt = mu*X
% d^aX/dt^a = mu*X
% X = X0 * exp{mu*t^a/a}
% x = X / X0 = exp{mu*t^a/a}

mu = 1;

alphamin = 0;
alphamax = 1;
nalpha = 6;

alphas = linspace(alphamin, alphamax, nalpha)';

%alphalegend = strcat("\alpha = ", string(alphas));
alphalegend = cell(size(alphas) + 1);

for i = 1:length(alphas)
    
    alphalegend{i} = ['$\alpha = ', num2str(alphas(i)), '$'];

end

alphalegend{length(alphas)+1} = ['$', 'Integer Solution', '$'];

tmin = 0;
tmax = 1;
nt = 1001;

t = linspace(tmin, tmax, nt);

[A, T] = meshgrid(alphas, t);

xs = exp(mu*T.^A./A);

intsol = exp(mu*t);



semilogy(t, xs, 'LineWidth', 1.5)
hold on
semilogy(t, intsol, '--')
xlabel('Time [-]')
ylabel('Population [-]')
title('Analytical Solution for Conformable Fractional Growth Model')

grid on

h = legend(alphalegend{1:length(alphas)+1});

set(h, 'Interpreter', 'latex');

hold off
