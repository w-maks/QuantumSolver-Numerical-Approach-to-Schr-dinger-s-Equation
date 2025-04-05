%Ewelina Borkowska
function [psi_X,psi_T,xR]=psix_bariera(E_ev, V_ev)
a_nm = 0.5;
dimx = 1000;
a = a_nm * 10^(-9);

% STAŁE I ZAMIANA JEDNOSTEK---------------------------------------------
E = 1.6021766208e-19 * E_ev; %[J]
V = 1.6021766208e-19 * V_ev; %[J]
m_e = 9.10938291e-31; %[kg]
e = 1.6021766208e-19; %[C]
h = 6.626070040e-34;
h_k = h / (2 * pi); % h kreslone
k_1 = sqrt(2 * m_e * E) / h_k; %[1/m]
C = 2 * m_e / (h_k * h_k);
% Zakres x
x = linspace(-6 * a, 6 * a, 3 * dimx);

% DO ANIMACJA---------------------------------------------------
w = E / h_k; %czestosc -> E = h_k * w
T = 2 * pi / w; %okres
nT = 110;
t = linspace(0, 1 * T, nT);
psi_T = exp(-1i * w * t); %FUNCKJA FALOWA ZALEZNA OD CZASU
U_ev = zeros(size(x));

%Rozwiązanie równania różniczkowego;
u0 = [1, 1i * k_1]; % warunki początkowe
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);
[xR, u] = ode45(@(x,u) row_bariera(x, u, V, E, m_e, h_k, a), flip(x), u0, options);
psi_X = u(:, 1);
psi_X = psi_X / max(abs(psi_X));%normalizacja

%funkcje-------------------------------------
function U = potencjal_bariera(x, V, a)
    U = V * double(abs(x) <= a);
end

function du = row_bariera(x, u, V, E, m_e, h_k, a)
    y = u(1);
    yd = u(2);
    potential = potencjal_bariera(x, V, a);
    k = 1i * sqrt(2 * m_e * (potential - E)) / h_k;
    du = [yd; -k^2 * y];
end

end