%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise1 - 1D Diffusion solver with the PSE method
%%%%%%%%%%%%%%%%%%%%%%%% 
% Input
% N:        Number of particles
% X:        Scalar domain size
% nu:        Scalar diffusion constant  
% dt:       Scalar time step  
% T:        Scalar integration time
%
% Output
% x:        (N x 1)-Vector of position in [0,X]   
% u:        (N x 1)-Vector of concentrations at x 
% 
% output: - concentration u at positions x (vectors) for x=0,...,X
% function [x,u] = pse(N,X,nu,dt,T)

function [x,u] = pse(N,X,nu,dt,T)

% initialization:
xp = linspace(-X,X,2*N);      % particle positions
up = xp.*exp(-xp.^2);         % initial concentration at particle positions
vp = 2*X/(2*N-1);             % particle volume
wp = vp.*up;                  % initial particle strength

h = vp(1);                    % In this setup, all interparticle spacings 
                              % are the same and since we are dealing with
                              % a 1D-problem the interparticle spacing is 
                              % the same as the particle volume.
epsilon = h;                  % kernel size (arbitrary choice)


% !!! We implemented both a "loop-version" and a "vector-version" of this
% function. Right now, the loop-variant is inactive and the vector-version
% active. This is faster for computation but maybe harder to understand.
% Both should yield the same result. You can uncomment the loop-version and
% inactivate the vector-version if you like.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% LOOP VARIANT >
% % For pse you need to know the distances between all particles. Compute all
% % distances Dij between the particles i and j.
% % The particles do not move, so the distances are valid for all
% % time steps. Now you can compute the kernel eta for each particle
% % pair:
% 
% eta = zeros(2*N,2*N);                           % initialize the matrix eta
% for i = 1:2*N                                   % from particle i ...
%     for j = 1:2*N                               % ... to particle j ...
%         Dij = xp(j) - xp(i);                    % ... we have this distance.
%         eta(i,j) = exp(-Dij^2/(4*epsilon^2))/(2*epsilon*sqrt(pi));
%     end;
% end;
% 
% % FINALLY: particle strength exchange
% 
% t = 0:dt:T;                                     % vector containing distinct time points t_i
% 
% for it = 2:length(t)                            % time stepping
%     for i = 1:2*N                               % loop over all particles
%         
%         summ = 0;                               % reset the sum
%         for j = 1:2*N                           % loop over all other particles
%             
%             % keep adding kernel weighted strength differences
%             summ = summ + (wp(j) - wp(i)) * eta(i,j);            
%             
%         end;                                    % end of loop over j
%         
%         dwpdt = (h*nu/epsilon^2)*summ;          % this is the time derivative dw/dt
%         
%         wp(i)= wp(i) + dt*dwpdt;                % compute the strength for
%                                                 % particle i at this time point
%         
%     end;                                        % end of loop over i
% end;                                            % end of time loop over it
%%%%%%%%%%%% < LOOP VARIANT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% VECTOR VARIANT >
% distance matrix Dij and kernel matrix eta:
Dij = repmat(xp,2*N,1) - repmat(xp',1,2*N);            
eta = exp(-Dij.^2/(4*epsilon^2)) / (2*epsilon*sqrt(pi));

% FINALLY: particle strength exchange

t = 0:dt:T;                                     % vector containing distinct time points t_i

for it = 2:length(t)                            % time stepping
    
    % the time derivative dw/dt:
    dwpdt = (h*nu/epsilon^2)*sum((repmat(wp',1,2*N) - repmat(wp,2*N,1)) .* eta,1);              
    % compute the new strengths:    
    wp = wp + dt*dwpdt;                         
        
end;                                            % end of time loop over it
%%%%%%%%%%%% < VECTOR VARIANT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% recover the new concentration at the particle positions:
up = wp./vp;

% your computation was run for a domain from -X to X, but you are interested
% only in the solution in the range between x = 0 and x = X.
x = xp(N+1:2*N);
u = up(N+1:2*N);

