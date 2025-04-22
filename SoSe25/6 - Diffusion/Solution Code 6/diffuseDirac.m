%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise 2 - Analytical solution of a diffusing Dirac
%%%%%%%%%%%%%%%%%%%%%%%%
% Input
% particlePos:  (numParticles x dim)-Vector of particle positions
% D:            Scalar diffusion constant
% t:            time t 
% initPos:      (1 x dim)-Vector of initial Dirac position
% 
% Output
% solMat:       (numParticles x 1)-Vector of analytical solution
%
% function solMat = diffuseDirac(particlePos,D,t,initPos)

function solMat = diffuseDirac(particlePos,D,t,initPos)

[numParticles,dim]=size(particlePos);

particleDists = sqrt(sum((particlePos-repmat(initPos,numParticles,1)).^2,2));

solMat = exp(-(particleDists.^2/(4*D*t)))/(4*pi*D*t)^(dim/2);