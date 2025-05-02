%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise 6, Question 1 - Main script
%%%%%%%%%%%%%%%%%%%%%%%% 
clear all; close all;

% define the parameters:
N = [50,100,200,400,800];   % vector containing different 
                            % numbers 
                            % of particles
X = 4;                      % domain we are interested in
nu = 0.0001;                % diffusion constant
dt = 10000./N.^2;           % time step
T = 10;                     % integration time

% intialize:
L2_pse = zeros(size(N));
L2_rw = zeros(size(N));

for i = 1:length(N)
    % compute u(x=0,...,X,t=T) using RW:
    [x_rw,u_rw] = randomwalk(N(i),X,nu,dt(i),T);    
    
    % compute the exact solution at positions x_rw:
    u_ex = exact_u(x_rw,T,nu);
    % compute the error measure L2 for the RWE method:
    L2_rw(i) = errormeasure(u_rw,u_ex);
    
    % plot the solutions:
    xfine = 0:X/100:X;
    figure;
    plot(xfine,exact_u(xfine,T,nu),'k-');
    hold on;
    plot(x_rw,u_rw,'k+');
    legend('exact solution','RW');
    title(strcat('N = ',num2str(N(i))));
    xlabel('position x');
    ylabel('u');
    
end

% convergence plot
figure;
loglog(N,L2_rw,'k-+');
legend('RW');
xlabel('N');
ylabel('L2 error');

    
    
