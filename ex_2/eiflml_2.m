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

function x_k = create_pos_data(num_samples, v1, v2, delta_t, q)
    % set velocity to v1, v2
    x_k = zeros(num_samples, 4);
    x_k(1, :) = [0 0 v1 v2];

    F = [1 0 delta_t 0; 0 1 0 delta_t; 0 0 1 0; 0 0 0 1]; % State transition

    var_x =  (delta_t ^ 3) / 3; % variance in position
    var_v = delta_t; % variance in velocity
    cov_xv = (delta_t ^ 2) / 2; % covariance between position and 
                                % velocity in the same dimension e.g. cov(x_1, v_1)
    
    Q = [
        var_x 0 cov_xv 0;
        0 var_x 0 cov_xv;
        cov_xv 0 var_v 0;
        0 cov_xv 0 var_v
    ] .* q;
        
    % Q_1D = [(delta_t ^ 3) / 3, (delta_t ^ 2) / 2; (delta_t ^ 2) / 2, delta_t] .* q;
    % Q = [Q_1D zeros(2, 2); zeros(2, 2) Q_1D];

    for i = 2:num_samples
        prev_state = x_k(i - 1, :).';
        state = (F * prev_state).' + mvnrnd([0 0 0 0], Q); % [w_k_1 w_k_2];
        x_k(i, :) = state;
    end
end

function plot_trajectory(x_k)
    plot(x_k(:, 1), x_k(:, 2), '-o', 'LineWidth', 1.5, 'MarkerSize', 2.5);
    xlabel('x_1');
    ylabel('x_2');
    title('Trajectory');
    grid on;
    % axis equal;
end