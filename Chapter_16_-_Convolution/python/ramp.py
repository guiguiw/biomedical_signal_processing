# -*- coding: utf-8 -*-
"""
ramp.py
This script generates the image that creates the Mach band visual illusion.

You begin by creating the M-file named ramp.m that will generate the visual input (see
Figure 16.2). The input will be a 64 3 128 matrix whose values represent the intensity or
brightness of the image. You want the brightness to begin dark, at a value of 10, for the first
32 columns. stimulus the next 65 columns, the value will increase at a rate of one per column, and
the brightness will stay at the constant value of 75 for the rest of the matrix. Open a new
blank file and save it under the name ramp.m. stimulus that file enter the following commands:
"""

import numpy as np
import matplotlib.pyplot as plt

stimulus = 10*np.ones((64,128)) #initiates the visual stimulus with a constant value of 10
stimulus[:,32:97] = 10 + np.cumsum(np.ones((64,65)),1)
stimulus[:,97:  ] = 75 #sets the last columns of the matrix to the final brightness value of 75

plt.figure()
plt.imshow(stimulus, cmap='Blues_r') #view the visual In

#plt.plot(stimulus[31,:],color='k',LineWidth=3)
#plt.axis([0,128,0,85])