function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

start_time = time;

iter_vec = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30]';
n_iter = length(iter_vec);

err_train = zeros(n_iter, n_iter);
err_val   = zeros(n_iter, n_iter);
precision_train = zeros(n_iter, n_iter);
precision_val   = zeros(n_iter, n_iter);
recall_train = zeros(n_iter, n_iter);
recall_val   = zeros(n_iter, n_iter);

for ic=1:n_iter
  
  for is=1:n_iter
      
    % Train the SVM
    model = svmTrain(X, y, iter_vec(ic), @(x1, x2) gaussianKernel(x1, x2, iter_vec(is)));
    visualizeBoundary(X, y, model);

    predictions = svmPredict(model, X);
    err_train(ic, is) = mean(double(predictions ~= y));
    precision_train(ic, is) = sum(y & predictions) / sum(predictions);
    recall_train(ic, is) = sum(y & predictions) / sum(y);

    predictions = svmPredict(model, Xval);
    err_val(ic, is) = mean(double(predictions ~= yval));
    precision_val(ic, is) = sum(yval & predictions) / sum(predictions);
    recall_val(ic, is) = sum(yval & predictions) / sum(yval);
  
    fprintf(['Error with C=%f, sigma=%f :\nTrain: %f\nCross-validation: %f\n'], iter_vec(ic), iter_vec(is), err_train(ic, is), err_val(ic, is));
  
  end
end

end_time = time;

% fprintf(['Train error.']);
% err_train
% precision_train
% recall_train
% 
% fprintf(['Cross-validation error.']);
% err_val
% precision_val
% recall_val

% save '-text', 'training_result.txt', err_train, precision_train, recall_train, err_val, precision_val, recall_val

pause;

% plot(err_train, err_val)
% pause;

[m, ic] = min(err_val);
[m, is] = min(min(err_val));

C = iter_vec(ic(is));
sigma = iter_vec(is);

fprintf(['Lowest error is %f with C = %f and sigma = %f.\nTime elpased: %f seconds.\n'], m, C, sigma,(end_time - start_time));
% 
% C = 1;
% sigma = 0.1;

% =========================================================================

end
