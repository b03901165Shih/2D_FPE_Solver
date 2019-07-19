function u = tridiag(a,b,c,r)
% Solve Ax=b with a,b,c being the lower, middle, and upper diagonal entries
% r: RHS vector ; N: lenght of a,b,c vectors
if (b(1)==0)
    fprintf(1,'Reorder the equations for the tridiagonal solver...\n');
end
beta = b(1) ;

N = length(a);

u = zeros(N,1);
gamma = zeros(N,1);
u(1) = r(1)/beta ;
% Start the decomposition and forward substitution
for j = 2:N
    gamma(j)=c(j-1)/beta;
    beta=b(j)-a(j)*gamma(j);
    if(beta==0)
        fprintf(1,'The tridiagonal solver failed...\n');
    end
    u(j)=(r(j)-a(j)*u(j-1))/beta;
end
% Perform the backsubstitution
for j = 1:(N-1)
    k = N-j ;
    u(k) = u(k) - gamma(k+1)*u(k+1);
end
