% 主程序
loadGlobleVariable;
loadTrainData;
%% 学习
display('learning...');
mdl = ClassificationTree.template('NVarToSample','all'); 
RF = fitensemble(allTrainFeatures, allTrainClasses,'Bag', 150, mdl,'type','classification'); % 袋装决策树
%% 对每个文件进行测试
display('test...');
allAccurency = cell(length(AllFileNumber), 1);
allConfmat = cell(length(AllFileNumber), 1); % 混淆矩阵
allOrder = cell(length(AllFileNumber), 1);
allLearningResult = cell(length(AllFileNumber), 1);
allCount = 0;
allCoractCount = 0;
for i = 1 : length(AllFileNumber)
    features = testFeatures{i};
    classes = testClasses{i};
    y_pred = predict(RF, features);
    [confmat, order] = confusionmat(classes, y_pred);
    allConfmat{i, 1} = confmat;
    allOrder{i, 1} = order;
    learningResult = zeros(length(confmat), 3);
    accuracyNumCnt = 0;
    for j = 1 : length(confmat)
        learningResult(j, 1) = confmat(j, j);
        learningResult(j, 2) = sum(confmat(j, :)) - confmat(j, j);
        learningResult(j, 3) = learningResult(j , 1) / sum(confmat( j, :));
        accuracyNumCnt = accuracyNumCnt + confmat(j, j);
    end
    allLearningResult{i} = learningResult;
    accuracy = accuracyNumCnt / sum(sum(confmat));
    allAccurency{i} = accuracy;
    allCount = allCount + sum(sum(confmat));
    allCoractCount = allCoractCount + accuracyNumCnt;
end
accurency = allCoractCount / allCount;
display(['total accurency'; accurency]);