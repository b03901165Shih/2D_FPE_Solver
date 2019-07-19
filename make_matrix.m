function [D1,D2,D11,D22,x1,x2]=make_matrix(M1,N1,M2,N2,x1_dt,x2_dt,D)
%[M0,Md,Am,x]=make_matrix(M,N);
% creates matrices to solve advection-diffusion problem
%INPUTS: M specifies the spatial domain x1=(-M1,M1), x2=(-M2,M2)
%N1,N2 are the grid size (size of matrices (N1*N2)x(N*N2) and vectors
%(N1*N2)x1)
%OUTPUT: D1,D2,D11,D22,x1,x2 are used to solve eqn

%params
dx1=2*M1/(N1-1);
if(dx1<0 || dx1>.5)
    disp('Make M1 smaller and/or N1 larger!!');
    return;
end
x1=(-M1:dx1:M1)'; %will be returned in output

dx2=2*M2/(N2-1);
if(dx2<0 || dx2>.5)
    disp('Make M2 smaller and/or N2 larger!!');
    return;
end
x2=(-M2:dx2:M2)'; %will be returned in output

%----Insert commands for creating D1, D2, and Am here

a = []; b = zeros(N1*N2,1)'; c = [];
for i=1:N2
    a_coeff = 0; c_coeff = 0;
    for k = 1:size(x1_dt,1)
        a_coeff = a_coeff - (-x1_dt(k,1))*(x2(i).^x1_dt(k,3)).*(x1(1:end-1).^x1_dt(k,2))./(2*dx1);
        c_coeff = c_coeff+ (-x1_dt(k,1))*(x2(i).^x1_dt(k,3)).*(x1(2:end).^x1_dt(k,2))./(2*dx1);
    end
    a = [a, 0, a_coeff'];
    c = [c, c_coeff', 0];
end
D1.a = a; D1.b = b; D1.c = c;
D1.matrix = make_tridiag(a,b,c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = []; b = zeros(N1*N2,1)'; c = [];
for i=1:N1
    a_coeff = 0; c_coeff = 0;
    for k = 1:size(x2_dt,1)
        a_coeff = a_coeff - (-x2_dt(k,1))*(x2(1:end-1).^x2_dt(k,3)).*(x1(i).^x2_dt(k,2))./(2*dx2);
        c_coeff = c_coeff+ (-x2_dt(k,1))*(x2(2:end).^x2_dt(k,3)).*(x1(i).^x2_dt(k,2))./(2*dx2);
    end
    a = [a, 0, a_coeff'];
    c = [c, c_coeff', 0];
end
D2.a = a; D2.b = b; D2.c = c;
D2.matrix = make_tridiag(a,b,c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = []; b = []; c = [];
for i=1:N2
    a = [a, 0, D(1)*(ones(N1-1,1)./(dx1*dx1))'];
    c = [c, D(1)*(ones(N1-1,1)./(dx1*dx1))',0];
    b = [b, -2*D(1)*(ones(N1,1)./(dx1*dx1))'];
end
D11.a = a; D11.b = b; D11.c = c;
D11.matrix = make_tridiag(a,b,c);

%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = []; b = []; c = [];
for i=1:N1
    a = [a, 0, D(2)*(ones(N2-1,1)./(dx2*dx2))'];
    c = [c, D(2)*(ones(N2-1,1)./(dx2*dx2))',0];
    b = [b, -2*D(2)*(ones(N2,1)./(dx2*dx2))'];
end
D22.a = a; D22.b = b; D22.c = c;
D22.matrix = make_tridiag(a,b,c);
