function [labels, centers] = k_means(dataset, k)
    sample_idxs = randi(length(dataset), k, 1);
    centers = dataset(:, sample_idxs);
    labels = zeros(length(dataset), 1);

    for n = 1:30
        for i = 1:length(dataset)
            least_distance = Inf;
            for j = 1:length(centers)
                distance = sum((dataset(:, i) - centers(:, j)) .^ 2);
                if distance < least_distance
                    least_distance = distance;
                    labels(i) = j;
                end
            end
        end
    
        new_centers = zeros(size(centers));
        for j = 1:k
            cluster_points = dataset(:, labels == j);
            new_centers(:, j) = mean(cluster_points, 2);
        end
        
        if all(new_centers == centers)
            disp("number of iterations")
            disp(n)
            break;
        end
        
        centers = new_centers;
    end
end