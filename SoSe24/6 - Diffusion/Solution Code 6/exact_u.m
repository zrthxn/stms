%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise1 - Exact solution of the test problem
%%%%%%%%%%%%%%%%%%%%%%%% 
% Input
% x:		 (numParticles x 1)-Vector of positions
% t:         Scalar time
% nu:		 Scalar diffusion constant
%
% Output
% u_ex:      (numParticles x 1)-Vector of exact solution  
% 
% function u_ex = exact_u(x,t,nu)

function u_ex = exact_u(x,t,nu)

u_ex = x/(1 + 4*nu*t)^1.5 .* exp(-x.^2/(1 + 4*nu*t));