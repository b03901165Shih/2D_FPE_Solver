function [t,p]=solve_advDif(D1,D2,D11,D22,x1,x2,dt,T_end,mu,sigma)

t=(0:dt:T_end)';

N1=length(x1); N2=length(x2);

p=zeros(N1,N2,length(t));

%mu = [0,10]; sigma = 1/2*eye(2);
[X1,X2] = meshgrid(x1,x2);
p(:,:,1) = reshape(mvnpdf([X1(:) X2(:)],mu,sigma),length(x2),length(x1))';

%***done setting initial condition***

p = reshape(p,N1*N2,length(t));

%----create matrix 'A' and vector 'b' here (Diffusion+Drift)
rhs_first = sparse(speye(N1*N2)+.5*dt*(D1.matrix+D11.matrix));
rhs_second = sparse(speye(N1*N2)+.5*dt*(D2.matrix+D22.matrix));

a_first =-.5*dt*(D2.a+D22.a);
b_first =ones(N1*N2,1)'-.5*dt*(D2.b+D22.b);
c_first =-.5*dt*(D2.c+D22.c);

a_second =-.5*dt*(D1.a+D11.a);
b_second =ones(N1*N2,1)'-.5*dt*(D1.b+D11.b);
c_second =-.5*dt*(D1.c+D11.c);

tic()    
for j=2:length(t)
    if rem(j,100)==0
        fprintf('Number of Iteration %d out of %d finished...\n',j,length(t));
    end
    %----solve for p(:,j)=....
    reshaped_r = reshape(reshape(rhs_first*p(:,j-1),N1,N2)',N1*N2,1);
    p_half = tridiag(a_first,b_first,c_first,reshaped_r);
    
    reshaped_r = reshape(reshape(rhs_second*p_half,N2,N1)',N1*N2,1);
    p(:,j) = tridiag(a_second,b_second,c_second,reshaped_r);      
end
toc()

p = reshape(p,N1,N2,length(t));