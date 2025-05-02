%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise1 - 1D Diffusion solver with the Random Walk method
%%%%%%%%%%%%%%%%%%%%%%%% 
% Input
% N:        Number of particles
% X:        Scalar domain size
% nu:       Scalar diffusion constant  
% dt:       Scalar time step  
% T:        Scalar integration time
%
% Output
% xbin:    (16 x 1)-Vector of bin position in [0,X]   
% ubin:    (16 x 1)-Vector of concentrations at xbin  
% 
% function [xbin,ubin] = randomwalk(N,X,nu,dt,T)

function [xbin,ubin] = randomwalk(N, X, nu, dt, T)

% initialization:
xp = linspace(-X, X, 2*N);
disp(xp); % initial particle positions
up = xp .* exp(-xp.^2);           % initial concentration at particle positions
vp = 2 * X/(2*N-1);               % particle volume
wp = vp .* up;                    % particle strength

% random walk
t = 0:dt:T;                                     % vector containing distinct time points t_i

sigma = sqrt(2*nu*dt);                          
for it = 2:length(t)                            % time stepping
    
    xp = xp + sigma*randn(size(xp));            % move the particles randomly according
                                                % to a normal distribution with
                                                % variation sigma^2
    
end                                            % end of time loop over it

% create bins to recover the new (current) concentration u:
M = 16;                                    % number of bins
edges = linspace(0,X,M+1);                 % binedges (borders between the bins)
xbin = (edges(1:end-1) + edges(2:end))/2;  % bincenters
dx = X/M;                                  % binwidth
ubin = zeros(size(xbin));                     % create vector ubin for the 
                                           % concentrations in each bin

for i = 1:M                    % loop over bins
    
    % find particles in bin ibin:
    ind1 = find(xp > edges(i));
    ind2 = find(xp <= edges(i+1));
    indcommon = intersect(ind1,ind2); % indeces of all particles in bin i
    % sum up their strengths:
    wp_sum = sum(wp(indcommon));
    % recover the the concentration ubin at this bin position xbin:
    ubin(i) = wp_sum/dx;
    
end


