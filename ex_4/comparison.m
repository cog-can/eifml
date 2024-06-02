clear all
close all


%% Arrays for
% N (number of measurements) and 
% sigma_x (standard deviation the the prior pdf)
N_min = 10;
N_max = 100;
N_array = N_min:N_max;

sigma_x_min = 0.05;
sigma_x_max = 0.25;
sigma_x_array = linspace(sigma_x_min, sigma_x_max, 100);


%% Influence of N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Question 2c): Implement your code here
ml_estimates = zeros(length(N_array), 1);
map_estimates = zeros(length(N_array), 1);

for i = 1:length(N_array)
    [ml_estimates(i), map_estimates(i)] = calculate_estimators(N_array(i), 0.15);
end

plot_comparison(N_array, "N", ml_estimates, map_estimates, "Estimate of X for varying N");
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Influence of sigma_x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Question 2c): Implement your code here
ml_estimates = zeros(length(sigma_x_array), 1);
map_estimates = zeros(length(sigma_x_array), 1);

for i = 1:length(sigma_x_array)
    [ml_estimates(i), map_estimates(i)] = calculate_estimators(50, sigma_x_array(i));
end

plot_comparison(sigma_x_array, "\sigma_x", ml_estimates, map_estimates, "Estimate of X for varying sigma_x");
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
