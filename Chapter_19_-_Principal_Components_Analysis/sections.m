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
%% 19.2.1 Covariance Matrices
% ------------------------------------------------------------------------------
%%
n = 500; %n 5 number of datapoints
a(:,1) = normrnd(0,1,n,1); %n random Gaussian values with mean 0, std. dev. 1
a(:,2) = normrnd(0,1,n,1); %Repeat for the 2nd dimension.
b(:,1) = normrnd(0,1,n,1); %n random Gaussian values with mean 0, std. dev. 1
%For b, the 2nd dimension is correlated with the 1st
b(:,2) = b(:,1)*0.5 + 0.5*normrnd(0,1,n,1);

%%
figure()
subplot(1,2,1)
plot(a(:,1),a(:,2),'.')
subplot(1,2,2)
plot(b(:,1),b(:,2),'.')

%%
var(a(:,1))
%Compute sample variance of 1st dim of "a"
c = a(:,1)-mean(a(:,1)); %Subtract mean from 1st dim of "a"
c'*c/(n-1)
%Compute sample variance of 1st dim of "a"
%Note the apostrophe denoting transpose(c)

%%
cov(a)
%Compute the covariance matrix for "a"
c = a-repmat(mean(a),n,1); %Subtract the mean from "a"
c'*c/(n-1)
%Compute the covariance matrix for "a"

%%
sigma = cov(b)
%Compute the covariance matrix of b
%Generate new zero-mean noise with the same covariance matrix
b2 = mvnrnd([0 0],sigma,n);

%%
figure()
subplot(1,2,1)
plot(b(:,1),b(:,2),'.')
subplot(1,2,2)
plot(b2(:,1),b2(:,2),'.')

% ------------------------------------------------------------------------------
%% 19.2.2 Principal Components
% ------------------------------------------------------------------------------

%%
[V, D] = eig(sigma) %V = eigenvectors, D = eigenvalues for covariance matrix sigma

%%
figure()
plot(b(:,1),b(:,2),'b.'); hold on
%Plot correlated noise
plot(3*[-V(1,1) V(1,1)],3*[-V(1,2) V(1,2)],'k') %Plot axis in direction of 1st eigenvector
plot(3*[-V(2,1) V(2,1)],3*[-V(2,2) V(2,2)],'k') %Plot axis in direction of 2nd eigenvector

%%
V2(:,1) = V(:,2); %Place the 1st principal component in the 1st row
V2(:,2) = V(:,1); %Place the 2nd principal component in the 2nd row
newB = b*V2; %Project data on PC coordinates

%%
figure()
subplot(1,2,1)
plot(b(:,1),b(:,2),'.')
axis([-4,4,-4,4])
subplot(1,2,2)
plot(newB(:,1),newB(:,2),'.')
axis([-4,4,-4,4])

%%
[coeff,score,latent] = princomp(b); %Compute principal components of data in b

%%
figure()
subplot(1,2,1)
plot(b(:,1),b(:,2),'.')
axis([-4,4,-4,4])
subplot(1,2,2)
plot(score(:,1),score(:,2),'.')
axis([-4,4,-4,4])




