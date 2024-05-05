load("trajectory_4.mat", "x_k_noise")

measurement = measure_pos(x_k_noise, 5, 5);

figure;
subplot(2, 1, 1)
plot_trajectory(x_k_noise)

subplot(2, 1, 2)
plot_trajectory(measurement)
title("Noisy measurement")
