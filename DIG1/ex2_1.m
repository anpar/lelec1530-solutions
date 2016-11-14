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
plot(Vin1, Vout1, Vin5, Vout5, Vin3, Vout3, Vin4, Vout4, Vin2, Vout2, 'Linewidth', 2);
legend('M1 bloqué, M2 triode', 'M1 sat, M2 triode', 'M1 sat, M2 sat',...
    'M1 triode, M2 sat', 'M1 triode, M2 bloqué');
xlabel('$V_{IN}$'); ylabel('$V_{OUT}$');
simpletikz('.', 'ex2_1');
