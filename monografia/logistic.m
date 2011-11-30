
close; clear; clc;

[X, y, Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB();


% Add Polynomial Features

% Note that mapFeature also adds a column of ones for us, so the intercept
% term is handled
% X = mapFeature(X(:,1), X(:,2));

% Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1);

% Set regularization parameter lambda to 1
lambda = 1;

% Compute and display initial cost and gradient for regularized logistic
% regression
[cost, grad] = costFunctionReg(initial_theta, Xtrain, ytrain, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);

fprintf('Error at initial theta: %f\n', mean(double(((sigmoid(Xval*initial_theta))>=0.5) ~= yval)));


% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);
	
[cost, grad] = costFunctionReg(theta, X, y, lambda);
fprintf('Cost after training: %f\n', cost);
fprintf('Error after training: %f\n', mean(double(((sigmoid(Xval*theta))>=0.5) ~= yval)));

