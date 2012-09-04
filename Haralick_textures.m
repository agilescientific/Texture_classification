function patterns(p, q, NumLev,Offset);
%p is the number of rows
%q is the number of rows of the graycomatrix kernel
load 'AmplitudeXL';
data = AmplitudeXL';
[nrows ncols] = size(data);
AuxCont= zeros(nrows, ncols);
AuxCorr= zeros(nrows, ncols);
AuxEner= zeros(nrows, ncols);
AuxHomo= zeros(nrows, ncols);
AuxEntr= zeros(nrows, ncols);
for i = 1+p: nrows - (p+1);
    for j = 1+q: ncols - (q+1);
        [glcm] = graycomatrix(data(i-p:i+p,j-q:j+q),'GrayLimits',[],'NumLevels',NumLev,'Offset',Offset);
        stats = graycoprops(glcm);
        AuxCont(i,j)= stats.Contrast;
        AuxCorr(i,j)= stats.Correlation;
        AuxEner(i,j)= stats.Energy;
        AuxHomo(i,j)= stats.Homogeneity;
        AuxEntr(i,j)= Entropy(data(i-p:i+p,j-q:j+q));
    end
    
end
%Offset 1
meanCont=AuxCont(:,:,1)./(mean(mean(AuxCont(:,:,1))));
meanCorr=6.*AuxCorr(:,:,1)./(mean(mean(AuxCorr(:,:,1))))-5.5;
meanEner=AuxEner(:,:,1)./(mean(mean(AuxEner(:,:,1)))) ; 
meanHomo=6.*AuxHomo(:,:,1)./(mean(mean(AuxHomo(:,:,1))))-5.5;
meanEntr=AuxEntr(:,:,1)./(mean(mean(AuxEntr(:,:,1))));
figure;
imagesc([meanCont meanCorr meanEner meanHomo]);
%the colorscale limits might need to be changed depending on choice of p,
%q, and data
colormap(bone);colorbar; caxis([0.0 1.5]); 
save save('Contrast.txt', 'meanCont', '-ascii');
save save('Correlation.txt', 'meanCorr', '-ascii');
save save('Energy.txt', 'meanHomo', '-ascii');
save save('Homogeneity.txt', 'meanEntr', '-ascii');

