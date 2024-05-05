v1 = 0;
v2 = 10;
q = 0.1;
delta_t = 1;

x_k = create_pos_data(60, v1, v2, delta_t, 0);

figure;
subplot(3, 2, 1:2);
plot_trajectory(x_k);
title('Trajectory without Noise');

% Subplots for x_k_noise
for i = 3:6
    x_k_noise = create_pos_data(60, v1, v2, delta_t, q);
    subplot(3, 2, i);
    plot_trajectory(x_k_noise);
    title('Trajectory with Noise');
end

% save('trajectory', 'x_k_noise')
