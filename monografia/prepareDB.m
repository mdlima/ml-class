function [Xtrain, ytrain, Xval, yval, Xtest, ytest] = prepareDB()
% Receives the complete training set and separates the test and cross-validation sets

  load "BaseparaRegressao.txt"

  m = size(BaseparaRegressao,1);
  
  val_size = round(m*0.2);
  
  X = BaseparaRegressao(:,2:end);
  y = BaseparaRegressao(:,1);
  
  mu    = mean(X(:,44));
  sigma = std(X(:,44));
  
  X(:,44) = X(:,44) - mu;
  X(:,44) = X(:,44) / sigma;

  Xval = X((m-val_size+1):end,:);
  yval = y((m-val_size+1):end);

  Xtest = [];
  ytest = [];
  % Xtest = BaseparaRegressao(round(m*0.2):round(m*0.4),2:end);
  % ytest = BaseparaRegressao(round(m*0.2):round(m*0.4),1);

  % Xtrain = BaseparaRegressao((size(yval)+size(ytest)+1):end,2:end);
  % ytrain = BaseparaRegressao((size(yval)+size(ytest)+1):end,1);
  Xtrain = X(1:(m-val_size),:);
  ytrain = y(1:(m-val_size));


end