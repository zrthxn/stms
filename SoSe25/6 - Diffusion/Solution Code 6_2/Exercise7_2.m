%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 6, Question 2 - Isotropic 2D diffusion with 
% the PSE operator
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%
% Global parameters

% Computational domain
dim=2;
lBounds=0;
uBounds=1;

% Particles on a grid (kind=1)
kind = 1;

% Number of particles and its spacing
numParticles = 26^2;
h = (uBounds-lBounds)/((numParticles^(1/dim)));
epsilon = h;

% Kernel and Verlet parameter
cutoff = 3*epsilon;

% Cell list parameter
cellSide = cutoff;

% Particle volume
V = ones(numParticles^(1/dim),numParticles^(1/dim))*h^2;

% Diffusion constant
D = 2;

%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation parameters

% VARY THE TIME STEPPING SUCH THAT THE STABILITY IS NOT 
% SATISFIED
% Time step (Stability criterion for Euler dt < h^2/(2*D)
dt = h^2/(3*D);

% Simulation end time
tMax = 0.05;

% Time vector
tVec = dt:dt:tMax;

%%%%%%%%%%%%%%%%%%%%%%%%
% Create particles and neighbor lists

% Create particle positions
particlePos = createParticles(numParticles,dim,lBounds,uBounds,kind);

% Create cell list
[particleMat,cellList,numCells] = createCellList(particlePos,lBounds,uBounds,cellSide);

% Create Verlet list
verletList = createVerletList(particleMat,cellList,numCells,cutoff);

% Apply initial conditions, i.e. set the initial strengths of the particles
% to a Dirac delta diffused by dt
numStren = 1;
initPos = [0.25,0.5];
particleStrength = diffuseDirac(particlePos,D,dt,initPos);

% Here you can add additional Dirac pulses, e.g. 
% initPos2 = [0.5,0.75];
% particleStrength = particleStrength + diffuseDirac(particlePos,D,dt,initPos2);

% Add the strength to the particle matrix
particleMat = [particleMat,particleStrength];

% creating the movie
fig = figure;
aviobj = VideoWriter('diffusion.avi');

%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the initial conditions
X=reshape(particleMat(:,1),sqrt(numParticles),sqrt(numParticles));
Y=reshape(particleMat(:,2),sqrt(numParticles),sqrt(numParticles));
Z=reshape(particleMat(:,dim+2),sqrt(numParticles),sqrt(numParticles));

plotIndices = ((cutoff/h)+1):(sqrt(numParticles)-(cutoff/h)); 
surf(X(plotIndices,plotIndices),Y(plotIndices,plotIndices),Z(plotIndices,plotIndices))
set(gca,'xtick',[])
set(gca,'ytick',[])
title('Initial conditions')
xlabel('x')
ylabel('y')
zlabel('concentration u')
pause(3)
%F = getframe(fig);
%aviobj = addframe(aviobj,F);
for t=tVec

    % PLEASE IMPLEMENT THE applyPSE routine (see template)
    % Apply Diffusion step with PSE
    pseSum = applyPSE(particleMat,verletList,epsilon,numStren);

    % Apply time step for all particle strengths (Only 1 in this case)
    for i=1:numStren
        particleMat(:,dim+1+i) = particleMat(:,dim+1+i) + V(:).*D*dt./epsilon^2 .* pseSum(:,i);
    end
    
    % Apply periodic boundary conditions
    tempMat = reshape(particleMat(:,dim+2),sqrt(numParticles),sqrt(numParticles));
    tempMat = periodicBoundaries(tempMat,h,cutoff);
    particleMat(:,dim+2) = tempMat(:);

    %%%%%%%%%%%%%%%%%%%%%%%%
    % Plotting the current solution
    
    X=reshape(particleMat(:,1),sqrt(numParticles),sqrt(numParticles));
    Y=reshape(particleMat(:,2),sqrt(numParticles),sqrt(numParticles));
    Z=reshape(particleMat(:,dim+2),sqrt(numParticles),sqrt(numParticles));
    
    surf(X(plotIndices,plotIndices),Y(plotIndices,plotIndices),Z(plotIndices,plotIndices),'LineStyle','none')
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    xlim([lBounds uBounds])
    ylim([lBounds uBounds])
    zlim([0 max(1,max(Z(:)))])
    hold off
    pause(0.01);
    %F = getframe(fig);
    %aviobj = addframe(aviobj,F);
end

%close(fig)
%aviobj = close(aviobj);


