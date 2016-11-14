Lmin = 0.18e-6;
mu_n = 0.04;
mu_p = 0.02;
Crout = 10e-15;
Vdd = 1.8;
Vt = 0.5;
Cox = 5e-3;
WLn = 1;
WLp = 2;

kn = WLn * mu_n * Cox;
kp = WLp * mu_p * Cox;

Vin = linspace(0, Vdd, 101);
Vin1 = [0, Vt];
Vout1 = [Vdd, Vdd];
Vin2 = [Vdd-Vt, Vdd];
Vout2 = [0, 0];
Vin4 = linspace(Vdd/2, Vdd-Vt, 30);
Vout4 = Vin4 -Vt - sqrt((Vin4-Vt).^2-(Vdd-Vin4-Vt).^2);
Vin5 = Vdd - Vin4;
Vout5 = Vdd - Vout4;
Vin3 = [Vdd/2, Vdd/2];
Vout3 = [Vout5(1), Vout4(1)];
%plot(Vin1, Vout1, Vin5, Vout5, Vin3, Vout3, Vin4, Vout4, Vin2, Vout2, 'Linewidth', 2);
%legend('M1 bloqué, M2 triode', 'M1 sat, M2 triode', 'M1 sat, M2 sat',...
%    'M1 triode, M2 sat', 'M1 triode, M2 bloqué');
%xlabel('$V_{IN}$'); ylabel('$V_{OUT}$');
%simpletikz('.', 'ex2_1');


% delai: calcul complet
% saturation
i = kn/2*(Vdd-Vt)^2;
t_sat = Crout * Vt/i;
% triode
tau = Crout / kn / (Vdd-Vt-0.9);
beta = -0.9^2/2*kn/Crout;
alpha = (-(Vdd-Vt)/tau+beta)*exp(t_sat/tau);
t_star = -tau*log((beta-Vdd/2/tau)/alpha);

% avec methode num:
[t_simu2, vout_simu2] = ode45(@(t, x)-kn/Crout*(Vdd-Vt-0.5*x).*x, [t_sat, t_star*1.5], Vdd-Vt);
t_simu1 = t_simu2;
vout_simu1 = -tau*(alpha*exp(-t_simu1/tau)-beta);
t_star1 = fzero(@(x)interp1(t_simu1, vout_simu1, x)-Vdd/2, t_star);
t_star2 = fzero(@(x)interp1(t_simu2, vout_simu2, x)-Vdd/2, t_star);
%plot(1e12*t_simu1, vout_simu1, 'b', 1e12*t_simu2, vout_simu2, 'r', 1e12*t_star1, Vdd/2, '*b', 1e12*t_star2, Vdd/2, '*r');
%legend('approximation 1er degré', 'équation complète');
%xlabel('$t (\SI{}{ps})$'); ylabel('$v_{OUT} (\SI{}{V})$');
%simpletikz('.', 'delai');

% resistance equivalente
Req = t_star/log(2)/Crout;
Rlin = 1/(kn*(Vdd-Vt));
k = Req/Rlin;

% saling techno
Req2 = k/(0.05*7e-3)/(1.2-0.4);
tPHL = Crout*Req2*log(2);