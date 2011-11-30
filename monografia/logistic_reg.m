%% Initialization
clear ; close all; clc

[X, y, Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB();

% Number of training examples
m = size(ytrain);

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

% Optimize lambda
for l=0:0.5:5
  
  lambda = l;

  % Plot learning curve
  figure(1);
  [error_train, error_val] = ...
      learningCurve(Xtrain, ytrain, Xval, yval, lambda);
  plot(1:m, error_train, 1:m, error_val);

  title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
  xlabel('Number of training examples')
  ylabel('Error')
  axis([0 130 0 10])
  legend('Train', 'Cross Validation')

  fprintf('Polynomial Regression (lambda = %f)\n\n', lambda);
  fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
  for i = 1:m
      fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
  end
    
    % fprintf('Program paused. Press enter to continue.\n');
    % pause;
end

% Train
[theta, J, exit_flag] = fminunc(@(t)(costFunctionReg(t, Xtrain, ytrain, lambda)), initial_theta, options);

[cost, grad] = costFunctionReg(theta, Xtrain, ytrain, lambda);

fprintf('Cost after training: %f\n', cost);

p = predict(theta, Xtrain);

fprintf('Train error: %f\n', mean(double(p ~= ytrain)) * 100);
fprintf('Cross-validation error: %f\n', mean(double(predict(theta, Xval) == yval)) * 100);
