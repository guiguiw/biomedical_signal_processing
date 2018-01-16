% ------------------------------------------------------------------------------
% FEDERAL UNIVERSITY OF UBERLANDIA
% Faculty of Electrical Engineering
% Biomedical Engineering Lab
% ------------------------------------------------------------------------------
% Author: Italo Gustavo Sampaio Fernandes
% Contact: italogsfernandes@gmail.com
% Git: www.github.com/italogfernandes
% ------------------------------------------------------------------------------
% Decription:
% ------------------------------------------------------------------------------
%% Clearing the enviroment
clear; close all; clc;
%% Loading the data

%% 17.3.1 Raster Plot
t1 = spike(1).times;
t2 = spike(2).times;
%%
figure %Create a new figure
hold on %Allow multiple plots on the same graph
for ii = 1:length(t1) %Loop through each spike time
    line([t1(ii) t1(ii)], [0 1]) %Create a tick mark at x = t1(ii) with height of 1
end
ylim([0 5]) %Reformat y-axis for legibility
xlabel('Time (sec)'); ylabel('Trial #')
%%
raster = zeros(47,401); %Initialize raster matrix
edges = [-1:.005:1]; %Define bin edges
for jj = 1:47 %Loop over all trials
    raster(jj,:) = histc(spike(jj).times,edges); %Count # of spikes in each bin
end
figure %Create figure for plotting
imagesc(Braster) %'B' inverts 0s and 1s
colormap('gray') %Zero plotted as black, one as white

%% 17.3.2 Peri-Event Time Histogram
edges = [-1:0.1:1]; %Define the edges of the histogram
peth = zeros(21,1); %Initialize the PETH with zeros
for jj = 1:47 %Loop over all trials
    peth = peth + histc(spike(jj).times,edges); %Add current trial's spike times
end
bar(edges,peth); %Plot PETH as a bar graph
xlim([-1.1 1]) %Set limits of X-axis
xlabel('Time (sec)') %Label x-axis
ylabel('# of spikes') %Label y-axis

%% 17.3.4 Curve Fitting

x = 1:20; %Create a vector with 20 elements
y = x; %Make y the same as x
z = randn(1,20); %Create a vector of random numbers
y = y + z ; %Add z to y, introducing random variation
plot(x,y, '.' ) %Plot the data as a scatter plot
xlabel('Luminance')
ylabel('Firing rate')
%%
p = polyfit(x,y,1) %Fits data to a linear 1 st degree polynomial
%%
hold on %Allows 2 plots of the same graph
yFit = x*p(1) + p(2); %Calculates fitted regression line
plot(x,yFit) %Plots regression
%%
predictor = [x' ones(20,1)]; %Bundle predictor variables together into a matrix
p2 = regress(y',predictor) %Perform regression
yFit2 = predictor*p2; %Calculate fit values

%% Now you will fit data to a more complicated function—a cosine. First, generate some
% new simulated data:
x = 0 : 0.1 : 30; %Create a vector from 0 to 10 in steps of 0.1
y = cos (x); %Take the cosine of x, put it into y
z = randn(1,301); %Create random numbers, put it into 301 columns
y = y + z; %Add the noise in z to y
figure %Create a new figure
plot (x,y) %Plot it
%%
mystring = 'p(1) + p(2) * cos ( theta - p(3) )'; %Cosine function in string form
myfun = inline( mystring, 'p', 'theta' ); %Converts string to a function
p = nlinfit(x, y, myfun, [1 1 0] ); %Least squares curve fit to inline function "myfun"
% Caso usando a funcao num arquivo m separado:
% p = nlinfit(x, y, @myfun, [1 1 0] ); %Least squares curve fit to function "myfun.m"
%%
hold on %Allows 2 plots of the same graph
yFit = myfun(p,x); %Calculates fitted regression line
plot(x,yFit,'k') %Plots regression
%%
%% TODO: nao funciona? pq?
predictor = [ones(301,1) sin(x)' cos(x)']; %Bundle predictor variables
p = regress(y',predictor) %Linear regression
yFit = predictor*p; %Calculate fit values
theta = atan2(p(2),p(3)); %Find preferred direction from fit weights


























