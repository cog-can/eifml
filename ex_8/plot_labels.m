function plot_labels(dataset, labels, w, support_vectors)
    figure;
    hold on;

    scatter(dataset(labels == 0, 1), dataset(labels == 0, 2), 'r', 'filled');
    scatter(dataset(labels == 1, 1), dataset(labels == 1, 2), 'b', 'filled');

    if nargin > 2
        w_normalized = w ./ w(2);
        x_values = [-1, 1];
        y_values = -w_normalized(1) * x_values - w_normalized(3);
        plot(x_values, y_values, 'k', 'LineWidth', 2);
        ylim([-1, 1]);
    end

    if nargin > 3
        scatter(support_vectors(1, 1), support_vectors(1, 2), 150, 'r', 'x');
        scatter(support_vectors(2, 1), support_vectors(2, 2), 150, 'b', 'x');
    end
    % if nargin > 3
    %     for i = 1:2
    %         if i == 1; color = 'r'; else color = 'b'; end %#ok<SEPEX>
    %         w_supp = support_vectors(i, :);
    %         w_normalized = w_supp ./ w_supp(2);
    %         x_values = [-1, 1];
    %         y_values = -w_normalized(1) * x_values - w_normalized(3);
    %         plot(x_values, y_values, append(color, '--'), 'LineWidth', 2);
    %         ylim([-1, 1]);
    %     end
    % end

    xlabel('X-axis');
    ylabel('Y-axis');
    legend('Class 0', 'Class 1', 'Decision Boundary');

    hold off;
end