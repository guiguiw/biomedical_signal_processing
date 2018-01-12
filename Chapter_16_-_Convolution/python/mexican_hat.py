# -*- coding: utf-8 -*-
# mexican_hat.m
# this script produces an N by N matrix whose values are
# a 2 dimensional Mexican hat or difference of Gaussians
#
import numpy as np
import matplotlib.pyplot as plt

N = 5 #matrix size is NXN
IE = 6  #ratio of inhibition to excitation
Se = 2  #variance of the excitation Gaussian
Si = 6  #variance of the inhibition Gaussian
S = 500 #overall strength of Mexican hat connectivity
#
[X,Y] = np.meshgrid(np.arange(0,N) - np.ceil(N/2),
                     np.arange(0,N) - np.ceil(N/2)) 
# - floor(N/2) to floor(N/2) in the row or column positions (for N odd)
# - N/2 + 1 to N/2 in the row or column positions (for N even)
#
THETA = np.arctan2(Y,X)
R = np.hypot(X,Y) 
# Switch from Cartesian to polar coordinates
# R is an N*N grid of lattice distances from the center  np.pixel
# i.e. R 5 sqrt((X).**2 1 (Y).**2) 1 eps 
EGauss = 1/(2* np.pi*Se**2)*np.exp(-R**2/(2*Se**2))  # create the excitatory Gaussian
IGauss = 1/(2* np.pi*Si**2)*np.exp(-R**2/(2*Si**2))  # create the inhibitory Gaussian
#
MH = S*(EGauss-IE*IGauss)  #create the Mexican hat filter
plt.figure()
plt.imshow(MH, cmap='Blues_r') #view the visual stimulus
plt.title('mexican hat "filter"',fontsize=22)

