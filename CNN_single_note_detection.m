% clear;clc
% training_data=importdata('audioArray_train.mat');
% training_data=training_data(:,1:1024);
% for i = 1:size(training_data,1)
% input_train(:,:,:,i) = training_data(i,:);
% end
clear;clc
training_data=importdata('audioArray_clean_train.mat');
for i = 1:size(training_data,1)
input_train(:,:,:,i) = training_data(i,:);
end

testing_data=importdata('audioArray_test.mat');
testing_data=testing_data(:,1:1024);
for i = 1:size(testing_data,1)
input_test(:,:,:,i) = testing_data(i,:);
end

testing_clean_data=importdata('audioArray_clean_test.mat');
testing_clean_data=testing_clean_data(:,1:1024);
for i = 1:size(testing_clean_data,1)
input_test_clean(:,:,:,i) = testing_clean_data(i,:);
end

load('pitch_label_train_clean.mat')
load('pitch_label_test.mat')

target_train = categorical(pitch_label_train_clean); 
target_test= categorical(pitch_label_test);  

% % % validation
idx = randperm(size(input_train,4),48076);  % % % train/validate/test  60/20/20
XValidation = input_train(:,:,:,idx);
input_train(:,:,:,idx) = [];
YValidation = target_train(idx);
target_train(idx) = [];

%% Define Network Architecture
% 
layers = [
    imageInputLayer([1024 1 1],"Name","imageinput")
    
    convolution2dLayer([1 512],1024,"Name","conv_1","Padding","same","Stride",[4 1])
    batchNormalizationLayer
    reluLayer("Name","relu_1")
    dropoutLayer(0.25,'Name','drop1') 
    
    maxPooling2dLayer([2 1],"Name","maxpool_1","Padding","same","Stride",[2 1])
    
    convolution2dLayer([64 1],128,"Name","conv_2","Padding","same","Stride",[2 1])
    batchNormalizationLayer
    reluLayer("Name","relu_2")
    dropoutLayer(0.25,'Name','drop2') 
    
    maxPooling2dLayer([2 1],"Name","maxpool_2","Padding","same","Stride",[4 1])
    
    convolution2dLayer([32 1],256,"Name","conv_3","Padding","same","Stride",[2 1])
    batchNormalizationLayer
    reluLayer("Name","relu_3")
    dropoutLayer(0.25,'Name','drop3') 
    
    fullyConnectedLayer(119,"Name","fc2")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
%                          'InitialLearnRate',0.01,...
%                          'LearnRateSchedule','piecewise', ...
%                          'LearnRateDropFactor',0.5, ...
%                          'LearnRateDropPeriod',5, ...
%                          'MaxEpochs',60, ...
checkpointPath = pwd;
options = trainingOptions('adam',...
                         'MiniBatchSize',128, ...       
                         'MaxEpochs',4, ...
                         'Verbose',0,...
                         'Shuffle','once',...
                         'ValidationData',{XValidation,YValidation},...
                         'ValidationFrequency',1800,...
                         'Plots','training-progress',...
                         'CheckpointPath',checkpointPath);

convnet1 = trainNetwork(input_train,target_train',layers,options);


%%% for 7 fold cv -> (1904-476)/7
% val_acc=ValidationAccuracy

predictedLabels = classify(convnet1,input_test)';
accuracy_noise_fx = 100*sum(predictedLabels == target_test')/numel(target_test)

predictedLabels_clean = classify(convnet1,input_test_clean)';
accuracy_clean = 100*sum(predictedLabels_clean == target_test')/numel(target_test)

plotconfusion(input_test,predictedLabels);

%% Resume Training

load('net_checkpoint__195__2018_07_13__11_59_10.mat','convnet1')

options = trainingOptions('adam',...
                         'MiniBatchSize',128, ...       
                         'MaxEpochs',4, ...
                         'Verbose',0,...
                         'Shuffle','once',...
                         'ValidationData',{XValidation,YValidation},...
                         'ValidationFrequency',1800,...
                         'Plots','training-progress',...
                         'CheckpointPath',checkpointPath);
                     
covnet2 = trainNetwork(XTrain,YTrain,net.Layers,options);

% double(classify(covnet,input_test_clean(:,:,:,29))')
% a=input_test_clean(:,:,:,29);a(1:512)=0
