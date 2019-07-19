function [ Mat ] = make_tridiag( a,b,c )
% Output a sparse tridiagonal matrix given a, b, c

N = length(a);
if (length(b) ~= N || length(c) ~= N)
    fprintf('Make sure the length of a, b, c are the same...\n');
end

x_indx = [2:N,1:N,1:N-1] ; 
y_indx = [1:N-1,1:N,2:N]; 
eles = [a(2:end),b(1:end),c(1:end-1)];

Mat = sparse(x_indx,y_indx,eles,N,N);

end

