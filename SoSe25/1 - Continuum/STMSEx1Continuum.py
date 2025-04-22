import numpy as np
import matplotlib.pyplot as plt

# Number of homogenous particles
N_homogenous=1_000

# Number of hetrogenous particles
N_hetrogenous=500

partBoxLen = 5
# Length of particle boxes

particles = -partBoxLen + 2 * partBoxLen * np.random.rand(N_homogenous, 3)
# Positions of particles between (-partBoxLen/2 , +partBoxLen/2) 
# Homogenous distributed randomly
print(particles.shape)

# =========================================================
# First subplot
fig = plt.figure(figsize=(12, 6))
ax1 = fig.add_subplot(2, 2, 1, projection='3d')
ax1.plot(particles[:, 0], particles[:, 1], particles[:, 2], 'r.', markersize=1)
ax1.set_xlim([-5, 5])
ax1.set_ylim([-5, 5])
ax1.set_zlim([-5, 5])
ax1.set_xlabel('$x$')
ax1.set_ylabel('$y$')
ax1.set_zlabel('$z$')
ax1.set_title('Random Particle Distribution')
ax1.grid(True)

# =========================================================
# Parameters for averaging boxes

maxLenAvgBox = 500
# MAX size of sampling boxes

numAvgSteps = 10000
# number of steps to go from 0 to maxLenAvgBox

lenAvgBox = np.linspace(0, maxLenAvgBox, numAvgSteps)
# linspace of length of averaging boxe, from 0 to maxLenAvgBox evenly spaced
# [0 1 2 3 .... maxLenAvgBox] in numAvgSteps steps

volAvgBox = (2 * lenAvgBox) ** 3
# [0 1 8 27 .... maxLenAvgBox^3] in numAvgSteps steps
# Linspace of volumes of sampling boxes, from 0 to maxLenAvgBox^3 evenly spaced

# ---------------------------------------------------------
# Calculation and plotting for the second subplot

numPartAvgBox = np.zeros(numAvgSteps)
# store for number of particles in each box [0 0 0 0 ...]

for i in range(numAvgSteps):
    # For every box, currParticles = all those particles where 
    # dimensions are within bounds of the boxes
    currParticles = np.where(
        (np.abs(particles[:, 0]) < lenAvgBox[i]) & 
        (np.abs(particles[:, 1]) < lenAvgBox[i]) & 
        (np.abs(particles[:, 2]) < lenAvgBox[i])
    )[0]
    numPartAvgBox[i] = len(currParticles)

# Second subplot (Hetrogeneous part)
ax2 = fig.add_subplot(2, 2, 2)
print(np.mean(numPartAvgBox / volAvgBox))
ax2.plot(volAvgBox, numPartAvgBox / volAvgBox, 'r*', markersize=3)
ax2.set_xlabel('Averaging Volume $V_{av}$')
ax2.set_ylabel('Density $\\rho$')
ax2.set_title('Density vs Averaging Volume')
ax2.grid(True)
ax2.set_xlim([0, 1000])

# =========================================================

# Positions of particles between (-partBoxLen/2 , + partBoxLen/2) 
# Hetrogenous distributed randomly
particles = np.vstack((
    # X
    -partBoxLen + 2 * partBoxLen * np.random.rand(N_hetrogenous, 3), 
    # Y
    3 + np.random.randn(N_hetrogenous, 3)
))
print(particles.shape)

# ---------------------------------------------------------
# Third subplot (Hetrogeneous part)
ax3 = fig.add_subplot(2, 2, 3, projection='3d')
ax3.plot(particles[:, 0], particles[:, 1], particles[:, 2], 'b.', markersize=1)
ax3.set_xlim([-5, 5])
ax3.set_ylim([-5, 5])
ax3.set_zlim([-5, 5])
ax3.set_xlabel('$x$')
ax3.set_ylabel('$y$')
ax3.set_zlabel('$z$')
ax3.set_title('Inhomogeneous Particle Distribution')
ax3.grid(True)

# =========================================================
# Calculation and plotting for the fourth subplot

numPartAvgBox = np.zeros(numAvgSteps)
# store for number of particles in each box [0 0 0 0 ...]

for i in range(numAvgSteps):
    # For every box, currParticles = all those particles where 
    # dimensions are within bounds of the boxes
    currParticles = np.where(
        (np.abs(particles[:, 0]) < lenAvgBox[i]) & 
        (np.abs(particles[:, 1]) < lenAvgBox[i]) & 
        (np.abs(particles[:, 2]) < lenAvgBox[i])
    )[0]
    numPartAvgBox[i] = len(currParticles)

# ---------------------------------------------------------
# Fourth subplot (Hetrogeneous part)
ax4 = fig.add_subplot(2, 2, 4)
print(np.mean(numPartAvgBox / volAvgBox))
ax4.plot(volAvgBox, numPartAvgBox / volAvgBox, 'b*', markersize=3)
ax4.set_xlabel('Averaging Volume $V_{av}$')
ax4.set_ylabel('Density $\\rho$')
ax4.set_title('Density vs Averaging Volume (Inhomogeneous)')
ax4.grid(True)
ax4.set_xlim([0, 1000])

plt.tight_layout()
plt.show()