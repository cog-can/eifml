function [xPosterior, PPosterior] = UkfUpdate(xPrior, PPrior, z, R, radarState)
    n = length(xPrior);
    root_PPrior = sqrtm(n .* PPrior);

    sigma_points = zeros(n, 2 * n + 1);
    sigma_points(:, 1) = xPrior;
    for i = 1:n
        sigma_points(:, i + 1) = xPrior + root_PPrior(:, i);
        sigma_points(:, i + n + 1) = xPrior - root_PPrior(:, i);
    end

    weights = zeros(2 * n + 1, 1);
    for i = 2:2 * n + 1
        weights(i) = 1 / (2 * n);
    end

    a_list = zeros(2, 2 * n + 1);
    for i = 1:2 * n + 1
        a_list(:, i) = MeasurementFunction(sigma_points(:, i), radarState);
    end
    
    a_mean = a_list * weights;
    S = zeros(2, 2) + R; % initialize with measurement noise
    cross_covar_matrix = zeros(n, 2);
    
    for i = 1:2 * n + 1
        delta_a = a_list(:, i) - a_mean;
        S = S + weights(i) * (delta_a * delta_a');
        cross_covar_matrix = cross_covar_matrix + weights(i) * ((sigma_points(:, i) - xPrior) * delta_a');
    end
    
    gain = cross_covar_matrix / S;
    residue = z - a_mean;

    xPosterior = xPrior + gain * residue;
    PPosterior = PPrior - gain * S * gain';
end
