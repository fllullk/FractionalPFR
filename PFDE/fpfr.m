alpha = 1;
beta = 1;
gamma = 0.5;

fig1 = 7;
fig2 = 8;

N = 21;

h = 1 / (N - 1);

x0 = 0;
xf = 1;
x = linspace(x0, xf, N);

t0 = 0;
tf = 2;
nt = 11;

trange = tf - t0;

lograte = 5 / 4;

% d1 = trange * (lograte^1 - 1) / (lograte^1 - lograte^(2-nt));

% d = d1 * ones(1, nt-1);

% d = d ./ (lograte.^(0:nt-2));

df = trange * (lograte^1 - 1) / (lograte^1 - lograte^(2-nt));

d = df * ones(1, nt-1);

d = d ./ (lograte.^(nt-2:-1:0));

tspan = [t0, cumsum(d)];

% tspan = linspace(t0, tf, nt);

tlegend = cell(size(tspan));

for i = 1:length(tspan)
    
    tlegend{i} = ['T = ', num2str(tspan(i)), ''];

end

D1 = zeros(N, N);

D1(1, 1:3) = [-3, 4, -1] / (2 * h);

for i = 2:N-1
    
    D1(i, i-1:i+1) = [-1, 0, 1] / (2 * h);
    
end

D1(end, end-2:end) = [1, -4, 3] / (2 * h);

D2 = zeros(N, N);

D2(1, 1:4) = [2, -5, 4, -1] / (h ^ 2);

for i = 2:N-1
    
    D2(i, i-1:i+1) = [1, -2, 1] / (h ^ 2);
    
end

D2(end, end-3:end) = [-1, 4, -5, 2] / (h ^ 2);

Pe = 25;

ic = ones(N, 1);
% ic = zeros(N, 1);
% ic(1) = 1; % BC 1 first part
% ic(1) = 0; % BC 1 first part
ic(1) = (4 * ic(2) - ic(3)) / (2 * h * Pe + 3); % BC 1 first part
ic(end) = (4 * ic(end-1) - ic(end-2)) / 3;

DaI = 0;

n = 1;

[t, C] = ode45(@(t, C) fodesys(t, C, D1, D2, Pe, DaI, n, h, x', alpha, beta, gamma), tspan, ic);

figure(fig1)

plot(x, C, 'LineWidth', 1.5)

hold on

grid on

str1 = sprintf('Dimensionless Concentration in a FPFR with %d nodes and Pe = %d, DaI = %d',  N, Pe, DaI);
str2 = '\alpha';
str3 = sprintf(' = %d, ', alpha);
str4 = '\beta';
str5 = sprintf(' = %d and ', beta);
str6 = '\gamma';
str7 = sprintf(' = %d', gamma);

titlestr = {str1, strcat(str2, str3, str4, str5, str6, str7)};

title(titlestr)

ylabel('C [-]')

xlabel('Z [-]')

%ylim([0, 1])
ylim([-0.2, 1.2]);

legend(tlegend, 'Location', 'northeastoutside')

hold off

figure(fig2)

[X, T] = meshgrid(x, t);

surf(X, T, C) %, 'EdgeColor', 'none');

colormap('cool');

title(titlestr)

xlabel('Z [-]')

ylabel('T [-]')

zlabel('C [-]')

function dCdt = fodesys(t, C, D1, D2, Pe, DaI, n, h, x, alpha, beta, gamma)

    dCdt = (((1/Pe)*D2*C).*exp(x*(1-beta))-D1*C.*exp(x*(1-gamma))-DaI*C.^n)/exp(t*(1-alpha));
    
    % dCdt(1) = 0; % BC 1 second part
    
    dCdt(1) = (4 * dCdt(2) - dCdt(3)) / (2 * h * Pe + 3); % BC 1 second part
    
    dCdt(end) = (4 * dCdt(end-1) - dCdt(end-2)) / 3; % BC 2 smooth max/min

end