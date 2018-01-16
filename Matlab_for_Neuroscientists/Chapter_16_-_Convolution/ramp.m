%ramp.m
% This script generates the image that creates the Mach band visual illusion.

% You begin by creating the M-file named ramp.m that will generate the visual input (see
% Figure 16.2). The input will be a 64 3 128 matrix whose values represent the intensity or
% brightness of the image. You want the brightness to begin dark, at a value of 10, for the first
% 32 columns. In the next 65 columns, the value will increase at a rate of one per column, and
% the brightness will stay at the constant value of 75 for the rest of the matrix. Open a new
% blank file and save it under the name ramp.m. In that file enter the following commands:

In = 10*ones(64,128); %initiates the visual stimulus with a constant value of 10% now ramp up the value for the middle matrix elements using cumsum
In(:,33:97) = 10 + cumsum(ones(64,65),2);
In(:,98:end) = 75; %sets the last columns of the matrix to the final brightness value of 75
imagesc(In); colormap(bone); %view the visual stimulus