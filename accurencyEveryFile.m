% 计算每个文件的准确率
allFile = getAllFileNumber();
for i=1:length(allFile)
    fileNumber = allFile(i);
end

y_pred1 = predict(RF1,Xtest);
[confmat1,order] = confusionmat(Ytest,y_pred1);