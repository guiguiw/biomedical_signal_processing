# -*- coding: utf-8 -*-
# ------------------------------------------------------------------------------
# FEDERAL UNIVERSITY OF UBERLANDIA
# Faculty of Electrical Engineering
# Biomedical Engineering Lab
# ------------------------------------------------------------------------------
# Author: Italo Gustavo Sampaio Fernandes
# Contact: italogsfernandes@gmail.com
# Git: www.github.com/italogfernandes
# ------------------------------------------------------------------------------
# Decription:
# ------------------------------------------------------------------------------
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import scipy as sp
# ------------------------------------------------------------------------------
# 19.2.1 Covariance Matrices
n = 500; # n = number of datapoints
a = np.zeros((n,2))
a[:,0] = np.random.normal(0,1,n) # n random Gaussian values with mean 0, std. dev. 1
a[:,1] = np.random.normal(0,1,n) # Repeat for the 2nd dimension.
b = np.zeros((n,2))
b[:,0] = np.random.normal(0,1,n) # n random Gaussian values with mean 0, std. dev. 1
b[:,1] = b[:,0]*0.5 + 0.5*np.random.normal(0,1,n) # For b, the 2nd dimension is correlated with the 1st

plt.figure()
plt.subplot(1,2,1)
plt.plot(a[:,0],a[:,1],'.')
plt.axis([-4,4,-4,4])
plt.subplot(1,2,2)
plt.plot(b[:,0],b[:,1],'.')
plt.axis([-4,4,-4,4])

np.var(a[:,0]) # Compute sample variance of 1st dim of "a"
c = a[:,0]-np.mean(a[:,0]) # Subtract mean from 1st dim of "a"
np.dot(c,c)/(n-1)
# c.T*c/(n-1) # Compute sample variance of 1st dim of "a"

sigma = np.cov(b) # Compute the covariance matrix of b
# b2 = mvnrnd([0 0],sigma,n); # Generate new zero-mean noise with the same covariance matrix

# ------------------------------------------------------------------------------
# 19.2.2 Principal Components
# ------------------------------------------------------------------------------

# [V, D] = eig(sigma) # V = eigenvectors, D = eigenvalues for covariance matrix sigma

























plt.show()














