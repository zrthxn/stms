%%%%%%%%%%%%%%%%%%%%%%%%
% Code for the Quorum Sensing detection (Exercise 5.Q2)
%%%%%%%%%%%%%%%%%%%%%%%%
% A. Load the Quorum Sensing data file 'QSBacterialPos.dat'
%    The data consists of 5.000 2D positions of bacterial cells in [0,10]
% B. Create a cell list with cell's side length 0.5
% C. Create a Verlet list with cutoff 0.5
% D. Search for cells that contain at least 20 bacteria.
% E. Search for bacteria that have at least 50 neighbors in the Verlet list.
% F. What is the maximum number of neighbors that bacteria have in the data
%    set.

tic
numParticles = 5e3;
dim = 2;
lBounds = 0;
uBounds = 10;
kind = 0;

% load data
particlePos = load('QSBacterialPos.dat');

% Create cell list
cellSide = 0.5;
[particleMat,cellList,numCells] = createCellList(particlePos,lBounds,uBounds,cellSide);

% Create Verlet list
cutoff = cellSide;
verletList = createVerletList(particleMat,cellList,numCells,cutoff);

% Critical value for the cell list
critCellNum = 20;

% Iterate over all cells
cellIndices=[];
for i=1:length(cellList)
    currParticleInds = cellList{i};
    if size(currParticleInds,1)>=critCellNum
        cellIndices = [cellIndices;currParticleInds];
    end
end

% Critical value for the Verlet neighborhood
critVerletNum = 50;

% Iterate over all particles
verletIndices=[];
maxIndex = [];
maxNeigh = 0;
for i=1:numParticles
    temp = verletList{i};
    size(temp,1)
    if size(temp,1)>=critVerletNum
        verletIndices = [verletIndices;i];
        if size(temp,1)>maxNeigh
            maxNeigh = size(temp,1);
            maxIndex = i;
        end
    end
end
toc

% Plot all bacteria and the ones in the most populated cells
figure
plot(particlePos(:,1),particlePos(:,2),'b.')
grid on
hold on
plot(particlePos(cellIndices,1),particlePos(cellIndices,2),'r*')
set(gca,'XTick',(lBounds:0.5:uBounds))
set(gca,'YTick',(lBounds:0.5:uBounds))

% Plot all bacteria and the ones with the most neighbors
figure
plot(particlePos(:,1),particlePos(:,2),'b.')
grid on
hold on
plot(particlePos(verletIndices,1),particlePos(verletIndices,2),'r*')
set(gca,'XTick',(lBounds:0.5:uBounds))
set(gca,'YTick',(lBounds:0.5:uBounds))

% Report and plot the bacterium with most neighbors
disp(['Particles ', num2str(maxIndex), ' has the most neighbors: ',num2str(maxNeigh)])

plot(particlePos(maxIndex,1),particlePos(maxIndex,2),'y.','MarkerSize',15)
set(gca,'XTick',(lBounds:0.5:uBounds))
set(gca,'YTick',(lBounds:0.5:uBounds))











