#%%
import numpy as np
from matplotlib import animation, pyplot as plt

#%%
dt = 0.001 # Time step
T = 10 # end time

#%%
def animate(frames: list | np.ndarray, x = 0, y = 1, fps = 30):    
    fig = plt.figure()
    plt.xlim((-5,5))
    plt.ylim((-5,5))
    ani = animation.ArtistAnimation(
        fig=fig,
        artists=[[plt.scatter(f[:, x], f[:, y], c="red", alpha=0.2)] for f in frames],
        interval=int((1/fps)*1000), 
        blit=True, 
        repeat_delay=1000)
    plt.close(fig)
    return ani

#%%
def random_walk(n, normal = False, homogenous = False, isotropic = False, T = 500):
    np.random.seed(1234)
    positions = np.zeros((n, 2))
    frames = []
    
    def D(x: np.ndarray, t: int):
        tau = np.ones((n, 2)) * 0.1
        
        if not normal:
            tau *= (T - t) * 0.005
            
        if not homogenous:
            tau += (np.tanh(x) + 1) * 0.02
            
        if not isotropic:
            tau[:, 1] += (np.cos(x[:, 1]) + 1) * 0.05
        
        return tau
    
    for t in range(T):
        x = (np.random.random((n, 2)) - 0.5) * 2
        positions += D(x, t) * x
        frames.append(positions.copy())

    a = animate(frames, x=0, y=1)
    fname = "diffusion"
    if not normal:
        fname += "_anomalous"
    if not homogenous:
        fname += "_inhomogenous"
    if not isotropic:
        fname += "_anisotropic"
    
    a.save(f"{fname}.gif")
    
random_walk(1000)

#%%
def particle_strength_exchange():
    ...
