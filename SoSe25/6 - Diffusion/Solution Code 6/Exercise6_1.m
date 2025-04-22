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

    % compute u(x=0,...,X,t=T) using PSE:
    [x_pse,u_pse] = pse(N(i),X,nu,dt(i),T);
    
    % compute the exact solution at positions x_pse:
    u_ex = exact_u(x_pse,T,nu);
    % compute the error measure L2 for the PSE method:
    L2_pse(i) = errormeasure(u_pse,u_ex);
    
    % plot the solutions:
    xfine = 0:X/100:X;
    figure;
    plot(xfine,exact_u(xfine,T,nu),'k-');
    hold on;
    plot(x_pse,u_pse,'ko');
    legend('exact solution','PSE');
    title(strcat('N = ',num2str(N(i))));
    xlabel('position x');
    ylabel('u');
    
end

% convergence plot
figure;
loglog(N,L2_pse,'k-o');
hold on;
loglog(N,L2_rw,'k-+');
legend('PSE');
xlabel('N');
ylabel('L2 error');

    
    
