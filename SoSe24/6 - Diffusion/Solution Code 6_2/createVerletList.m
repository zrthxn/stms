%%%%%%%%%%%%%%%%%%%%%%%% 
% Code for Question 10 - Creation of Verlet lists without symmetry
%%%%%%%%%%%%%%%%%%%%%%%% 
% Input
% particleMat:  (numParticles x dim+1)-Matrix of particle positions and cell index
% cellList:     Matlab cell structure of length prod(numCells) (number of cells)
% numCells:     (dim x 1)- Vector that contains the number of cells per
%               dimension
% cutoff:       Scalar distance cutoff that defines the neighborhood. It should be
%               equivalent to the side length of a cell
% 
% Output
% verletList:   Matlab cell structure of length numParticles. Each element
%               contains the indices of the particles, i.e. the row numbers
%               in the particleMat matrix
%
% function verletList = createVerletList(particleMat,cellList,numCells,cutoff)


function verletList = createVerletList(particleMat,cellList,numCells,cutoff)

[numParticles,dim] = size(particleMat);
dim = dim-1;

% Initialize Verlet list
verletList = cell(numParticles,1);

% Iterate over all particles and build Verlet list
for n=1:numParticles
    % collect all surrounding cell indices
    currCellInd = particleMat(n,dim+1);
    adjCellIndices = adjacentCells(currCellInd,numCells);
    allCellIndices = [currCellInd,adjCellIndices]';
    
    % collect all particle ID's
    currPartIndices=cell2mat(cellList(allCellIndices));
    
    currVec=[];
    numRows = length(currPartIndices);
    
    % iterate over all collected particles around the current particle
    tempMat = repmat(particleMat(n,1:dim),numRows,1);
    temp = currPartIndices(find(sum(((tempMat-particleMat(currPartIndices,1:dim)).^2),2)<=cutoff^2));
    verletList{n} = temp(find(temp~=n));
end



