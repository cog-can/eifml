function [support_vectors] = get_support_vectors(dataset, labels_true, w)
    % Find the closest point to the decision boundary
    line_params = [w(1) 1 w(3)];
    dist_0 = Inf;
    dist_1 = Inf;
    for i = 1:length(dataset)
        distance = line_params * [dataset(i, :).'; 1];        
        
        if labels_true(i) == 0 && abs(distance) < dist_0
            dist_0 = abs(distance)
            point_0 = dataset(i, :)
        end

        if labels_true(i) == 1 && abs(distance) < dist_1
            dist_1 = abs(distance);
            point_1 = dataset(i, :);
        end
    end
    support_vectors = [point_0; point_1];
    support_vectors(1, :)
end