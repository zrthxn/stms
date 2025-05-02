%%%%%%%%%%%%%%%%%%%%%%%%
% Code for Exercise5_1c - Plotting of points in cell and Verlet lists
%%%%%%%%%%%%%%%%%%%%%%%%
% The next task is dedicated to visually verify your implementation and to
% improve your skills with Octave's plotting tools.
% Write an Octave script that creates 10.000 particles in 2D uniformly
% at random in the unit box. Create a cell list and a Verlet list
% with cell side length (cutoff) 0.05.
% Create a figure and plot all particles in blue.
% Choose a random cell index and color all particles that are contained
% in this cell in green. Color the particles in adjacent cells in yellow.
% Pick a random particle of the randomly chosen cell
% and color its Verlet neighbors in red.

%%%%%%%%%%%%%%%%%%%
% Set up parameters

dim = 2;
numParticles = 1e4;

% simulation boundaries
lBounds = 0;
uBounds = 1;

% cell side length = interaction cutoff
cutoff = 0.05;

%%%%%%%%%%%%%%%%%%%
% Particle creation either on a grid (kind=1) or uniformly at random (kind=0)
kind = 0;

particlePos = createParticles(numParticles,dim,lBounds,uBounds,kind);

figure
plot(particlePos(:, 1),particlePos(:, 2), 'b.')
xlabel('x')
ylabel('y')
grid on
box on
%%%%%%%%%%%%%%%%%%%
% Create cell list

[particleMat,cellList,numCells] = createCellList(particlePos,lBounds,uBounds,cutoff);


%%%%%%%%%%%%%%%%%%%
% Test and plot the implementation

% Determine the particles in a random cell
maxCellInd = max(particleMat(:, dim+1));
randCell = randi(maxCellInd);   % randCell = ceil(rand*maxCellInd);

% show the randomly chosen 2D/3D cell index
[I,J] = ind2sub(numCells,randCell);

% There are two possibilities to extract the particles contained in the
% randomly chosen cell

% (i) Collect the particles from the particle matrix
% randCellIndices=find(particleMat(:,dim+1)==randCell);

% (ii) Collect the particles from the cell list
randCellIndices=cellList{randCell};

figure
title(['Displaying the cell with indices I=', int2str(I), ', J=',int2str(J)])
%subplot(1,2,2)
plot(particleMat(randCellIndices,1), particleMat(randCellIndices,2),'c.')
xlim([lBounds uBounds])
ylim([lBounds uBounds])
set(gca, 'XTick', (lBounds(1):cutoff:uBounds(1)))
set(gca, 'YTick', (lBounds(1):cutoff:uBounds(1)))
grid on
box on
xlabel('x')
ylabel('y')
hold on

plot(particleMat(randCellIndices, 1), particleMat(randCellIndices, 2), 'bo')

%%%%%%%%%%%%%%%%%%%
% Check adjacency implementation by determining the adjacent cells of the
% randomly chosen cell
adjCellIndices = adjacentCells(randCell, numCells)';
adjPartIndices = cell2mat(cellList(adjCellIndices));

plot(particleMat(adjPartIndices, 1),particleMat(adjPartIndices, 2),'y.')

%%%%%%%%%%%%%%%%%%%%%
% Create Verlet list
verletList = createVerletList(particleMat, cellList, numCells, cutoff);

% Choose the first particle in the previously chosen random cell
randParticle = cellList{randCell};
randParticle = randParticle(1);

% Plot the selected particle and its neighbors

figure
plot(particleMat(randParticle,1), particleMat(randParticle, 2),'m.','MarkerSize', 10)
xlim([lBounds uBounds])
ylim([lBounds uBounds])
zlim([lBounds uBounds])
set(gca, 'XTick', (lBounds(1):cutoff:uBounds(1)))
set(gca, 'YTick', (lBounds(1):cutoff:uBounds(1)))
set(gca, 'ZTick', (lBounds(1):cutoff:uBounds(1)))
grid on 
box on
xlabel('x')
ylabel('y')
zlabel('z')
hold on

verletParts = verletList{randParticle};

% Plot neighbors
plot(particleMat(verletParts, 1), particleMat(verletParts,2), 'r.', 'MarkerSize',20)

% Plot transparent cutoff sphere
[x, y, z] = ellipsoid(particleMat(randParticle, 1), particleMat(randParticle, 2), 0, cutoff, cutoff, cutoff, 30);
surf(x, y, z)
shading interp
colormap(gray);
alpha(.4)


