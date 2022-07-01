matlabroot='E:\MATLAB\Plots\ACE'
DatasetPath = fullfile(matlabroot);
imds = imageDatastore(DatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');
CountLabel = imds.countEachLabel;
%% 
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');
net = alexnet;
deepNetworkDesigner(net)
inputSize = net.Layers(1).InputSize
%% 
lgraph = layerGraph(net); 
numClasses = numel(categories(imdsTrain.Labels))
newLearnableLayer = fullyConnectedLayer(numClasses, ...
    'Name','new_fc', ...
    'WeightLearnRateFactor',10, ...
    'BiasLearnRateFactor',10);
    
lgraph = replaceLayer(lgraph,'fc8',newLearnableLayer);
newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'output',newClassLayer);

%% 
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter( ...
    'RandXReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',10, ...
    'InitialLearnRate',3e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',50, ...
    'Verbose',true, ...
    'Plots','training-progress');
    %% 
    netTransfer = trainNetwork(augimdsTrain,lgraph,options);
    [YPred,scores] = classify(netTransfer,augimdsValidation);
    %%
idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end
%% 
YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation)
%% 
layer = 23;
name = net.Layers(layer).Name
channels = 1;
I = deepDreamImage(net,name,channels, ...
    'PyramidLevels',1);
figure
I = imtile(I,'ThumbnailSize',[28 28]);
imshow(I)
title(['Layer ',name,' Features'],'Interpreter','none')
imsave