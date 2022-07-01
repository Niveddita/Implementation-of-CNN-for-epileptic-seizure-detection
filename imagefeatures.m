layer = 20;
name = net.Layers(layer).Name
channels = 10;
I = deepDreamImage(net,name,channels, ...
    'PyramidLevels',1);
figure
I = imtile(I,'ThumbnailSize',[114 114]);
imshow(I)
imsave
%% 
X = imread("5000.png");
inputSize = net.Layers(1).InputSize(1:2);
X = imresize(X,inputSize);
label = classify(net,X)
[scoreMap,featureMap,featureImportance]  = imageLIME(net,X,label,'Segmentation','grid','NumFeatures',64,'NumSamples',3072);
figure
imshow(X)
hold on
imagesc(scoreMap,'AlphaData',0.5)
colormap jet
colorbar
%% 
X = imread("5000.png");
inputSize = net.Layers(1).InputSize(1:2);
X = imresize(X,inputSize);
label = classify(net,X)
scoreMap = occlusionSensitivity(net,X,label);
figure
imshow(X)
hold on
imagesc(scoreMap,'AlphaData',0.5);
colormap jet
colorbar
%% 
scoreMap = gradCAM(net,X,label);
figure
imshow(X)
hold on
imagesc(scoreMap,'AlphaData',0.5)
colormap jet
colorbar

%% 
figure;
act1 = activations(net,X,'conv1');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I = imtile(mat2gray(act1),'GridSize',[8 8]);
imshow(I)