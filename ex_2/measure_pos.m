function z_k = measure_pos(x_k, sigma_1, sigma_2)
    % Model measurement as z = Hx + w
    H = [1 0; 0 1];
    R = [sigma_1^2 0; 0 sigma_2^2];

    z_k = zeros(length(x_k), 2);
    for i = 1:length(z_k)
        pos = x_k(i, 1:2).';
        disp(pos)
        z_k(i, :) = (H * pos).' + mvnrnd([0 0], R);
    end
end