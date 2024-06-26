function [x, t, C] = pfr_fun(N, x0, xf, t0, tf, nt, Pe, DaI, n)
    h = 1 / (N - 1);
    
    x = linspace(x0, xf, N);
    
    trange = tf - t0;

    lograte = 5 / 4;

    % d1 = trange * (lograte^1 - 1) / (lograte^1 - lograte^(2-nt));

    % d = d1 * ones(1, nt-1);

    % d = d ./ (lograte.^(0:nt-2));

    df = trange * (lograte^1 - 1) / (lograte^1 - lograte^(2-nt));

    d = df * ones(1, nt-1);

    d = d ./ (lograte.^(nt-2:-1:0));

    tspan = [t0, cumsum(d)];

    tspan = linspace(t0, tf, nt);

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

    ic = ones(N, 1);
    % ic = zeros(N, 1);
    % ic(1) = 1; % BC 1 first part
    % ic(1) = 0; % BC 1 first part
    ic(1) = (4 * ic(2) - ic(3)) / (2 * h * Pe + 3); % BC 1 first part
    ic(end) = (4 * ic(end-1) - ic(end-2)) / 3;

    [t, C] = ode45(@(t, C) odesys(t, C, D1, D2, Pe, DaI, n, h), tspan, ic);
end

function dCdt = odesys(t, C, D1, D2, Pe, DaI, n, h)

    dCdt = (1 / Pe) * D2 * C - D1 * C - DaI * C .^ n;
    
    % dCdt(1) = 0; % BC 1 second part
    
    dCdt(1) = (4 * dCdt(2) - dCdt(3)) / (2 * h * Pe + 3); % BC 1 second part
    
    dCdt(end) = (4 * dCdt(end-1) - dCdt(end-2)) / 3; % BC 2 smooth max/min

end