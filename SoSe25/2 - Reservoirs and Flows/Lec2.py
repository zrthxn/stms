import numpy as np
import matplotlib.pyplot as plt

c1 = 1.3
c2 = 1

xT = 2e5
x0 = 0.8e5


dt = 0.1
t = np.arange(0, 10+dt, dt)
x = np.zeros_like(t)
x[0] = x0  # initial value

for i in range(len(t) - 1):
    x[i+1] = x[i] + dt * (-(c1 + c2) * x[i] + c2 * xT)

plt.plot(t, x)


dt = 1.01
t = np.arange(0, 10+dt, dt)
x = np.zeros_like(t)
x[0] = x0  # initial value

for i in range(len(t) - 1):
    x[i+1] = x[i] + dt * (-(c1 + c2) * x[i] + c2 * xT)

plt.plot(t, x, 'r')

# Analytically known solution
t = np.arange(0, 10+0.1, 0.1)
x = (c2 * xT) / (c1 + c2) + (x0 - (c2 * xT) / (c1 + c2)) * np.exp(-(c1 + c2) * t)

plt.plot(t, x, '--k')

plt.xlabel('Time t', fontsize=14)
plt.ylabel('Number x of species S1', fontsize=14)
plt.legend(['\Delta t = 0.1', '\Delta t = 1.01', 'Analytical'], loc='upper left', fontsize=14)
plt.savefig('explicitEuler.jpg')
plt.show()
