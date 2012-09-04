function [Facies Pmax] = FuzzyFacies_generic(num_clusters)
%Cluster_n = the number of clusters to classify the data into

%load Attributes into workspace; 
%Load patterns data into workspace (Contrast, Correlation, etc.)
tic
load 'a' 
load 'b'
load 'c' 
% etc... add more if needed for each attribute
[n1 m1] = size(a); % all data must be the same size (used in reshape).

%Construct reshaped attribute vectors for input to FCM algorithm
%AMP3D = reshape(Amp3d,n*m,1);
tic
A = reshape(a,n1*m1,1); 
A = (A./max(A)); %Normalize

B = reshape(b,n1*m1,1); 
B = (B./max(B)); %Normalize

C = reshape(C,n1*m1,1);
C = (C./max(C)); %Normalize
%etc. for each attribute, add more if needed
toc
%Concatenate Data matrix for fcm algorithm
DATA = [A B C];
toc
%Do the fcm
tic
[centers,U,obj_fcn] = fcm(DATA,num_clusters,100);
%pick the Pmax (maxVal) and the Facies value (maxInd) where it occurs
[maxVal maxInd] = max(U);
%Reshape the Pmax and Facies 
toc
Facies = reshape(maxInd,n1,m1);
Pmax = reshape(maxVal,n1,m1);
toc
%scrsz = get(0,'ScreenSize');
%figure('Position',[50 50 scrsz(4)/1.5 scrsz(4)/1.3])
imagesc(Facies'); colorbar; 
%figure;
%imagesc(Pmax'./max(max(Pmax')));
%export Facies and Pmax as simple ascii
save('Pmax100.txt', 'Pmax', '-ascii');
save('Facies100.txt', 'Facies', '-ascii');