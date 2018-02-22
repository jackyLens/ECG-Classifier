% 计算每一个 Dat 文件中取出的模版波形数量
getRRTypeEveryFile;
rowNum = length(AllFileNumber);
colNum = NumOfRRType;
tampletWaveCntEveryFile = zeros(rowNum, colNum);
for i = 1 : colNum
    j = 1;
    while j <= rowNum
        if tampletWaveCntEveryFile(j, i) < rrTypeEveryFile(j, i) && sum(tampletWaveCntEveryFile(:,i)) < NumOfTamplet
            tampletWaveCntEveryFile(j, i) = tampletWaveCntEveryFile(j, i) + 1;
        end
        j = j+1;
        if j == rowNum + 1 && sum(tampletWaveCntEveryFile(:,i)) < NumOfTamplet
            j = 1;
        end
    end
end

