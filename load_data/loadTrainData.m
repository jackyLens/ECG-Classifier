% 按七三划分取出训练数据和测试数据
loadTampletWaves;
numOfFile = length(AllFileNumber);
trainFeatures = cell(numOfFile, 1);
trainClasses = cell(numOfFile, 1);
testFeatures = cell(numOfFile, 1);
testClasses = cell(numOfFile, 1);
for i = 1 : numOfFile % parfor
    display(['loadTrainData... : fileNumber ' i]); 
    [features, classes] = getFeaturesAndClasses(AllFileNumber(i), tampletWaves, NumOfRRType, NumOfTamplet, RRTypeMap, LenOfWave);
    cv = cvpartition(classes,'holdout',0.3);
    trainFeatures{i} = features(training(cv),:);
    trainClasses{i} = classes(training(cv));
    testFeatures{i} = features(test(cv),:);
    testClasses{i} = classes(test(cv));
end
allTrainFeatures = zeros(0, 2+NumOfTamplet*NumOfRRType);
allTrainClasses = cell(0, 1);
for i=1 : numOfFile
    allTrainFeatures = [allTrainFeatures; trainFeatures{i}];
    allTrainClasses = [allTrainClasses; trainClasses{i}];
end