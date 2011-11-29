%% Initialization
clear ; close all; clc

[X, y, Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB();


% Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1);

% Set regularization parameter lambda to 1
lambda = 1;

% Compute and display initial cost and gradient for regularized logistic
% regression
[cost, grad] = costFunctionReg(initial_theta, Xtrain, ytrain, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, Xtrain, ytrain, lambda)), initial_theta, options);

[cost, grad] = costFunctionReg(theta, Xtrain, ytrain, lambda);

fprintf('Cost after training: %f\n', cost);

p = predict(theta, Xtrain);

fprintf('Train Accuracy: %f\n', mean(double(p == ytrain)) * 100);
fprintf('Cross-validation Accuracy: %f\n', mean(double(predict(theta, Xval) == yval)) * 100);
