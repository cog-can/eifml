function [x_ML, x_MAP] = calculate_estimators(N,sigma_x)
    % CALCULATE_ESTIMATORS 
    % This function calculates the Maximum Likelihood (ML) and the
    % Maximum a posteriori (MAP) estimator
    %
    % Insert your code implementations at the marked positions.
    %
    % Your implementations should base on your analytical derivations of the
    % ML and MAP estimator from question 1.
    % The verification part below compares your answers to the estimators
    % obtained when evaluating the likelihood function and the posterior
    % pdf.
    % 
    % N: number of measurements
    % sigma_x: standard deviation the the prior pdf


    %% Generate measurements
    measurement_mean = 5;
    data = randn(N, 1) + measurement_mean;


    %% Maximum Likelihood estimator
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Question 2a): Implement your code here
    %
    x_ML = mean(data);
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %% Maximum a posteriori estimator
    mean_x = 3;
    sigma = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_MAP = ((N*x_ML) + (mean_x * sigma^2 / sigma_x^2)) / (N + sigma^2 / sigma_x^2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %% Verification
    xRange = linspace(-5, 10, 1000);
    sigma = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Question 2b): Implement your code here
    z_pdf = @(z, x, sigma) (1 / sqrt(2 * pi * sigma^2)) * exp(-(1 / (2 * sigma^2)) * (z - x)^2);
    x_ML_max = xRange(1); % x that maximizes likelihood
    x_MAP_max = xRange(1);
    max_log_likelihood = -Inf;
    max_log_aposteriori = -Inf;

    for i = 1:length(xRange)
        log_p_z_given_x = 0;
        for j = 1:length(data)
            log_p_z_given_x = log_p_z_given_x + log(z_pdf(data(j), xRange(i), sigma));
        end
        log_aposteriori = log_p_z_given_x + log(z_pdf(xRange(i), mean_x, sigma_x));

        if log_p_z_given_x > max_log_likelihood
            x_ML_max = xRange(i);
            max_log_likelihood = log_p_z_given_x;
        end

        if log_aposteriori > max_log_aposteriori
            x_MAP_max = xRange(i);
            max_log_aposteriori = log_aposteriori;
        end
    end

    error_ML = abs((x_ML_max - x_ML)) / x_ML;
    error_MAP = abs((x_MAP_max - x_MAP)) / x_MAP;

    if error_ML > 0.01 || error_MAP > 0.01
        error("Error over 1%!")
    end

end