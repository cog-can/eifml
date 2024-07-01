function [theta] = perceptron_train(train_set, labels, theta)
    lr = 0.1;
    iter = 0;
    max_iter = 20;
    converges = false;
    while ~converges && iter < max_iter
        iter = iter + 1;
        converges = true;
        for i = 1:length(train_set)
            x = [train_set(i, 1); train_set(i, 2); 1];
            residue = theta.' * x;
            label = 2 * labels(i) - 1;

            if label * residue <= 0
                theta = theta + lr * label * x;
                converges = false;
            end
        end
    end
end