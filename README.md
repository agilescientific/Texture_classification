Texture-classification
======================

Texture classification of seismic data

These are MATLAB m-files that I used to do the image classification and cluster analysis of geothermal seismic data. The variable names number of attributes for clustering will needed to be changed to suit your application.

If you save your seismic data as "Amplitude.txt", and load it into your local workspace, the texture classification code should work.

You will need to export seismic attributes as text files (OpendTect seismic data export as text works fine), and load them into the workspace so their name matches the code.

Note that clustering is optimized when attributes are normalized or vary over the same range. Consider scaling attributes so they have the same range. For instance, amplitude [-1 to 1], semblance from [0 to 2]
