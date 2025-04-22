%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise1 - 1D Diffusion solver with the PSE method
%%%%%%%%%%%%%%%%%%%%%%%% 
% Input
% u_num:     (numParticles x 1)-Vector of numerical solution
% u_ex:      (numParticles x 1)-Vector of exact solution
%
% Output
% L2:       L2 error   
% 
% function L2 = errormeasure(u_num,u_ex)

function L2 = errormeasure(u_num,u_ex)

errors = u_num - u_ex;
N = length(errors);

L2 = sqrt(sum(errors.^2)/N);