close all
clearvars

delta_t = 1; % Time step is one second
F = [1 0 delta_t 0; 0 1 0 delta_t; 0 0 1 0; 0 0 0 1]; % State transition
proNoise = 20; % Process noise intensity q
var_x =  (delta_t ^ 3) / 3; % variance in position
var_v = delta_t; % variance in velocity
cov_xv = (delta_t ^ 2) / 2; % covariance between position and 
                            % velocity in the same dimension e.g. cov(x_1, v_1)

Q = [
    var_x 0 cov_xv 0;
    0 var_x 0 cov_xv;
    cov_xv 0 var_v 0;
    0 cov_xv 0 var_v
] .* proNoise;

sigmaX = 5; % Measurement error standard deviation in x
sigmaY = 5; % Measurement error standard deviation in y
R = [sigmaX^2 0; 0 sigmaY^2]; % TASK 2 - Complete the measurement error covariance matrix
H = [1 0 0 0; 0 1 0 0]; % TASK 2 - Complete the measurement matrix

load('data.mat')

estimate = zeros(4,60);
gain_x = zeros(1,60);
gain = zeros(4, 2, 60);

% Indexing for 60 times steps
for i = 1:60
   %Store all the measurements
    z = measurements(:,i); 
    if i == 2
        % In the second time step perform initialisation
        mean = [z(1) z(2) z(1)-measurements(1,i-1) z(2)-measurements(2,i-1)]';
        covar = [R(1,1) 0 R(1,1) 0; 0 R(2,2) 0 R(2,2); R(1,1) 0 2*R(1,1) 0; 0 R(2,2) 0 2*R(2,2)];
        estimate(:,i) = mean;
    elseif i > 2
       
        % Perform the Kalman filter prediction
        [priorMean, priorCovar] = kalmanPrediction(mean,covar,F,Q);
        
        if i == 4
            figure;
            plot_surface(priorMean, priorCovar);
            title("Prior at step 4");
        end
        
        % Perform the Kalman filter update and log the Kalman gain
        % additionally
        [mean,covar,gain(:, :, i)] = kalmanUpdate(priorMean,priorCovar,z,H,R);
        gain_x(:, i) = gain(1, 1, i);
        
        if i == 4
            figure;
            plot_surface(mean, covar);
            title("Posterior at step 4")
        end

        % Log the estimate
        estimate(:,i) = mean;
    end
end

% TASK 5 - Plot the true state, the measurements and state estimate
figure;
plot(targetState(1,:), targetState(2,:), 'b', ...
    estimate(1,:), estimate(2,:), 'g', ...
    measurements(1,:), measurements(2,:), 'rx');
xlabel('X Position');
ylabel('Y Position');
legend('True State', 'State Estimate', 'Measurements');


% TASK 6 - Plot the Kalman filter gain
figure;
plot(1:60, gain_x);
xlabel('Step');
ylabel('Gain in X Dimension');
title('Gain in X Dimenssion');
