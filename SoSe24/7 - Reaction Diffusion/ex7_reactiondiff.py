#%%
import numpy as np
from matplotlib import animation, colormaps, pyplot as plt

#%%
u_t = lambda a,b,k,u,v: a + (k * (u**2) * v) - ((b+1) * u)
v_t = lambda b,k,u,v: (b * u) - (k * (u**2) * v)

#%%
# Brusselator - Deterministic
def deterministic(a: float, b: float, k: float, u_0: float, v_0: float, tau: float = 0.01, T: int = 2000):
    u = [u_0]
    v = [v_0]
    
    for _ in range(T):
        u_ = u[-1] + tau*u_t(a, b, k, u[-1], v[-1])
        v_ = v[-1] + tau*v_t(b, k, u[-1], v[-1])
        u.append(u_)
        v.append(v_)
    
    plt.plot(u)
    plt.plot(v)
    plt.show()

deterministic(
    a = 2, 
    b = 6,
    k = 1,
    u_0 = 0.7,
    v_0 = 0.04)

#%%
# Brusselator - Gillespe's SSA
def gillespe_ssa():
    ...