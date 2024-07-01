N = 15;
dataset = 2 .* rand(N, 2) - 1;

% pick random 2 points
random_points = dataset(randi(N, 2), :);
x1 = random_points(1, 1);
x2 = random_points(2, 1);
y1 = random_points(1, 2);
y2 = random_points(2, 2);

% for y = mx + b
m = (y2 - y1) / (x2 - x1);
b = y1 - m * x1;
w = [-m 1 -b].';

labels = zeros(N, 1);
for i = 1:N
    labels(i) = get_label(dataset(i, :).', w);
end

theta = [1 1 1].';
theta = perceptron_train(dataset, labels, theta);

labels_pred = zeros(N, 1);
for i = 1:N
    labels_pred(i) = get_label(dataset(i, :).', theta);
end

plot_labels(dataset, labels, w);
title("Original dataset and labels")
plot_labels(dataset, labels_pred, theta);
title("Prediction after PLA")

support_vectors = get_support_vectors(dataset, labels, w);
plot_labels(dataset, labels, w, support_vectors)
title("Support points")

x1 = support_vectors(1, :).';
y1 = -1;
x2 = support_vectors(2, :).';
y2 = 1;

A = [
    eye(2), zeros(2, 1), -y1*x1, -y2*x2; 
    zeros(1, 2), 0, -y1, -y2;
    y1*x1', y1, 0, 0; 
    y2*x2', y2, 0, 0
];

b = [zeros(2, 1); 0; 1; 1];

solution = linsolve(A, b);

w = solution(1:end-1);
b = solution(end);

plot_labels(dataset, labels, solution, support_vectors)
title("Boundary from SVM")
