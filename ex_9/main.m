load('data.mat') %% x: (2x45)

figure;
scatter(x(1, :), x(2, :), "r", "filled");
title("Scatter plot of the originial dataset");

[labels, centers] = k_means(x, 2);

plot_labels(x, labels, centers);

[projected_data, eigenvectors] = pca(x, 2);

figure;
scatter(projected_data(1, :), 0, "r", "filled");
title("Scatter plot of dataset projected onto 2 pca dimensions");
xlabel('u_1');
ylabel('u_2');

figure;
hold on;
scatter(x(1, :), x(2, :), "r", "filled");
for i = 1:size(eigenvectors, 2)
    v = eigenvectors(:, i) * 0.5;
    quiver(0, 0, v(1), v(2), 'b', 'LineWidth', 1.5);
end
title("Principal components with the original dataset");
xlabel('x')
ylabel('y')

[projected_data , eigenvectors] = pca(x, 1);

figure;
scatter(projected_data(1, :), 0, "r", "filled");
title("Scatter plot of dataset projected onto 1 pca dimensions");
xlabel('u_1');