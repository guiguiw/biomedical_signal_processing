# -*- coding: utf-8 -*-
#mach_illusion.m

import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

#reset the variables before executing

from mexican_hat import * #creates the Mexican hat matrix, MH, & plots
from ramp import * #creates image with ramp from dark to light, stimulus, & plots
A = signal.convolve2d(stimulus,MH,'valid')  #convolve image and Mexican hat

plt.figure()
plt.imshow(A, cmap='Blues_r') #visualize the "perceived" brightness
plt.title('Perceived',fontsize=22)

#create plot showing the profile of both the input and the perceived brightness
plt.figure()
plt.plot(stimulus[31,:],'k',linewidth=5, label='input brightness')
plt.axis([0,128,-20,120])
plt.plot(A[31,:],'b-.',linewidth=2, label='perceived brightness') 
plt.legend()

plt.show()
