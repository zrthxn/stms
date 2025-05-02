% Analytic solution of 1D diffusion
%

function uExVec = uEx(xVec,t,nu)

uExVec = xVec./(1+4*nu*t)^(3/2) .* exp(-xVec.^2/(1+4*nu*t));
