#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 30 16:48:00 2024
@author: gopan
"""

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.widgets import Slider, Button

c1 = 1 # Initial C1
c2 = 1 # Initial C2

x0 = 0.8e5
# Initial time
xT = 2e5 
# Final time

# ==============================
# Matplotlib stuff, safe to ignore

# Create the figure and the line that we will manipulate
fig, ax = plt.subplots()
# adjust the main plot to make room for the sliders
fig.subplots_adjust(bottom=0.3)

ax_c1 = fig.add_axes([0.15, 0.15, 0.65, 0.03])
c1_slider = Slider(ax_c1, label='C1', valmin=0.1, valmax=2, valinit=c1)
ax_c2 = fig.add_axes([0.15, 0.05, 0.65, 0.03])
c2_slider = Slider(ax_c2, label="C2", valmin=0.1, valmax=2, valinit=c2)

# ==============================

def system(t, dt, k1=c1_slider.val, k2=c2_slider.val):
    # Differential equation represented as a function
    x = np.zeros_like(t)
    x[0] = x0  # initial value
    for i in range(len(t) - 1):
        x[i+1] = x[i] + dt * (-(k1 + k2) * x[i] + k2 * xT)
    return x


# Analytically known solution
t = np.arange(0, 10+0.1, 0.1)
x = (c2 * xT) / (c1 + c2) + (x0 - (c2 * xT) / (c1 + c2)) * np.exp(-(c1 + c2) * t)
p0, = ax.plot(t, x, '--k')

# Convergent Case
dt_1 = 0.10 # Initial dt1
t1 = np.arange(0, 10+dt_1, dt_1)
p1, = ax.plot(t1, system(t1, dt_1))
# The function to be called anytime a slider's value changes
def update_c1(val):
    p0.set_ydata(system(t, 0.1, k1=val, k2=c2_slider.val))
    p1.set_ydata(system(t1, dt_1, k1=val, k2=c2_slider.val))
    p2.set_ydata(system(t2, dt_2, k1=val, k2=c2_slider.val))
    fig.canvas.draw_idle()
c1_slider.on_changed(update_c1)


# Divergent Case
dt_2 = 1.01 # Initial dt2
t2 = np.arange(0, 10+dt_2, dt_2)
p2, = ax.plot(t2, system(t2, dt_2))
# The function to be called anytime a slider's value changes
def update_c2(val):
    p0.set_ydata(system(t, 0.1, k2=val, k1=c1_slider.val))
    p1.set_ydata(system(t1, dt_1, k2=val, k1=c1_slider.val))
    p2.set_ydata(system(t2, dt_2, k2=val, k1=c1_slider.val))
    fig.canvas.draw_idle()
c2_slider.on_changed(update_c2)


ax.legend(['Analytical', '$\Delta$t = 0.1', '$\Delta$t = 1.01'], loc='upper left', fontsize=14)
plt.xlabel('Time t', fontsize=14)
plt.ylabel('Number $x$ of species S1', fontsize=14)
plt.show()