Cs = 100e-6;
Rs = 6e3;
s = zpk('s');
H = -10*(1+s*Cs*Rs)/(7+s*Cs*Rs);
bode(H);
simpletikz('.', 'bode1');
