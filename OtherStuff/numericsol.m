tspan = linspace(0.1, 5, 1001);

ic = [1];

mu = 1;

alphas = linspace(-1, 1, 11);

alphalegend = cell(size(alphas) + 1);

for i = 1:length(alphas)
    
    alphalegend{i} = ['$\alpha = ', num2str(alphas(i)), '$'];

end

alphalegend{length(alphas)+1} = ['$', 'Integer Solution', '$'];

figure(1)

for alpha = alphas
   
[t, x] = ode45(@(t, x) odesysf(t, x, alpha, mu), tspan, ic);

semilogy(t, x, 'LineWidth', 1.5)

hold on    
    
end

[t, x] = ode45(@(t, x) odesys(t, x, mu), tspan, ic);

semilogy(t, x, '--')

xlabel('Time [-]')
ylabel('Population [-]')
title('Numerical Solution for Conformable Fractional Growth Model')

grid on

h = legend(alphalegend{1:length(alphas)+1});

set(h, 'Interpreter', 'latex');

hold off

function dxdt = odesysf(t, x, alpha, mu)

    dxdt(1) = mu * x(1) ./ (t.^(1-alpha));

end

function dxdt = odesys(~, x, mu)

    dxdt(1) = mu * x(1);
    
end