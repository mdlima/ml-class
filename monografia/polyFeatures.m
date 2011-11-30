function [X_poly] = polyFeatures(X)
%POLYFEATURES Maps X into combinatory features

sizeX = size(X);

% You need to return the following variables correctly.
% X_poly = zeros(sizeX(1), sizeX(2)*p);
X_poly = X(:,1);

% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power.
%
% 

for i=2:sizeX(2)
  
  X_poly = [X_poly X(:,i)];
  
  for j=(i+1):sizeX(2)
    X_poly = [X_poly X(:,i).*X(:,j)];
  end
  
end





% =========================================================================

end
