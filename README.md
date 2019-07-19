# 2D_FPE_Solver

This repository is a Matlab solver for two dimensional Fokker-Planck equation using alternating direction implicit (ADI) method

## Usage

1. Uncomment one of the parameters setting section in solve_2D_FPE.m: 
    - heat diffusion
    - linear oscillator
    - bimodal oscillator 
    - van der pol oscillator
2. Run solve_2D_FPE.m
3. Run movie_scpt.m to see a movie of the solution


## Self-defined parameters

Assume that we want to solve a 2D FPE like this:

> [dx1; dx2] = [f1(x1,x2); f2(x1,x2)]dt + [D1; D2] dW(t)

where W(t) is a 1D wiener process, f1 and f2 defines the drifting force for x1 and x2 respectively.
In the code, parameter x1_dt represents f1 and parameter x2_dt represent f2.

For x1_dt and x2_dt, each row defines a term in f1 and f2.
Say f1 = 0.5*x1+x2, x1_dt will have two rows since f1 have two terms.

Each row should have three elements, representing coefficent, x1 dependency and x2 dependency.
Say a row = [a, b, c], this row represents: a*(x1^b)*(x2^c)

As a result, for f1 = 0.5*x1+x2, x1_dt should be: [0.5, 1, 0; 1, 0, 1] (Same method for x2_dt)

- Parameter D  = [D1; D2]
- Parameter dt = unit of time ; T_end = total time
- Parameter M1 = left and right boundary for x1 (x1 = [-M1, M1])
- Parameter M2 = left and right boundary for x2 (x2 = [-M2, M2])
- Parameter N1 = # of grids for x1
- Parameter N2 = # of grids for x2
- Parameter mu = mean of Gaussian (initial condition)
- Parameter sigma = covariance of Gaussian (initial condition)

## Reference Paper
Pichler, Lukas, Arif Masud, and Lawrence A. Bergman. "Numerical solution of the Fokker–Planck equation by finite difference and finite element methods—a comparative study." Computational Methods in Stochastic Dynamics. Springer, Dordrecht, 2013. 69-85.
