
close; clear; clc;

[Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB();


% Try different SVM Parameters here
[C, sigma] = datasetParams(Xtrain, ytrain, Xval, yval);

% Train the SVM
% model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
