clear;
%{
% heat diffusion
x1_dt = [0,0,0];
x2_dt = [0,0,0];
D = [0.5,0.5];
dt=0.01;
T_end = 25;
M1 = 10; M2 = 10;
N1 = 200; N2 = 200;
mu = [0,0]; sigma = 1/5*eye(2); 
%}
%{
% linear oscillator
x1_dt = [1,0,1];
x2_dt = [-0.2,0,1; -1,1,0];
D = [0,0.2];
dt=0.01;
T_end = 25;
M1 = 10; M2 = 10;
N1 = 200; N2 = 200;
mu = [5,5]; sigma = 1/9*eye(2); 
%}
%{
% bimodal oscillator
x1_dt = [1,0,1];
x2_dt = [1,1,0;-0.4,0,1;-0.1,3,0];
D = [0,0.4];
dt=0.0075;
T_end = 15;
M1 = 10; M2 = 15;
N1 = 300; N2 = 300;
mu = [0,10]; sigma = 1/2*eye(2); 
%}
%{
% van der pol oscillator
x1_dt = [1,0,1];
x2_dt = [-0.1,2,1;0.1,0,1; -1,1,0];
D = [0,0.5];
dt=0.01;
T_end = 50;
M1 = 10; M2 = 10;
N1 = 200; N2 = 200;
mu = [4,4]; sigma = 1/2*eye(2); 
%}

[D1,D2,D11,D22,x1,x2]=make_matrix(M1,N1,M2,N2,x1_dt,x2_dt,D);
[t,p]=solve_advDif(D1,D2,D11,D22,x1,x2,dt,T_end,mu,sigma);