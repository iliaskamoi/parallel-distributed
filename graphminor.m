%Function given 
function M = graphminor(A,c)
  m = max(c);
  [ii,jj,vv] = find(A);
  M = sparse(c(ii),c(jj),vv,m,m);
end
