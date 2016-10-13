k = 39;
v_bias = 4;
v_t0 = 1;
% part 1: V_out < 1 V
% Q1 blocked, I_in = -I2
y1 = linspace(0, 1, 10);
x1 = -k/2*(v_bias - v_t0 - y1).^2;
% part 2: 1 V < V_out < 3 V
% linear, automatically interpolated by plot -;)

% part 3: V_out > 3 V
% Q2 blocked, I_in = I1
y3 = linspace(3, 4, 10);
x3 = k/2*(y3 - v_t0).^2;

plot([x1, x3], [y1, y3], [-78, 78], [1, 3], '.b');
xlabel('$I_{in}$ (\SI{}{\micro\ampere})');
ylabel('$V_{out}$ (\SI{}{V})');

simpletikz('../', 'ex3');
