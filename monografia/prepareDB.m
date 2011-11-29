function [Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB()
% Receives the complete training set and separates the test and cross-validation sets

  load "BaseparaRegressao.txt"

  m = size(BaseparaRegressao,1);

  Xval = BaseparaRegressao(1:round(m*0.2),2:end);
  yval = BaseparaRegressao(1:round(m*0.2),1);

  Xtest = BaseparaRegressao(round(m*0.2):round(m*0.4),2:end);
  ytest = BaseparaRegressao(round(m*0.2):round(m*0.4),1);

  Xtrain = BaseparaRegressao((size(yval)+size(ytest)+1):end,2:end);
  ytrain = BaseparaRegressao((size(yval)+size(ytest)+1):end,1);


end