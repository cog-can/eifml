function plot_labels(dataset, labels, centers)
    figure;
    hold on;
    colors = ['r', 'g', 'b', 'y', 'm', 'c'];

    for i = 1:length(centers)
        scatter(centers(1, i), centers(2, i), 120, 'MarkerEdgeColor', colors(mod(i - 1, 6) + 1), 'Marker', 'x', 'LineWidth', 4);
        scatter(dataset(1, labels == i), dataset(2, labels == i), colors(mod(i - 1, 6) + 1), 'filled');
    end

    title("Clustered data with " + length(centers) + " centers")
    xlabel('X');
    ylabel('Y');
end