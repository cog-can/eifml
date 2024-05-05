function plot_trajectory(x_k)
    plot(x_k(:, 1), x_k(:, 2), '-o', 'LineWidth', 1.5, 'MarkerSize', 2.5);
    xlabel('x_1');
    ylabel('x_2');
    title('Trajectory');
    grid on;
    % axis equal;
end