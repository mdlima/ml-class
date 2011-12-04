Sigma = X'*X/dim(X,1);
[U, S, V] = svd(Sigma);

totalS=sum(sum(S));

is = 0;

for i=1:size(sumS)
  i
  is = is+sumS(i)/totalS
endfor