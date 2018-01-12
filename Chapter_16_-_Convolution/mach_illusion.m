%mach_illusion.m
clear all; close all
mexican_hat %creates the Mexican hat matrix, MH, & plots
ramp %creates image with ramp from dark to light, In, & plots
A = conv2(In,MH,'valid'); %convolve image and Mexican hat
figure; imagesc(A); colormap(bone) %visualize the "perceived" brightness
%create plot showing the profile of both the input and the perceived brightness
figure; plot(In(32,:),'k','LineWidth',5);axis([0,128,-20,120])
hold on; plot(A(32,:),'b-.','LineWidth',2);
lh = legend('input brightness','perceived brightness',2);