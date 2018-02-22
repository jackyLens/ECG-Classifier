% 计算每个 RR 文件中每种类别出现的次数
rrTypeEveryFile = zeros(length(AllFileNumber), length(AllRRType));
for i = 1:length(AllFileNumber)
    [~, rrType, ~] = loadRRFile(AllFileNumber(i));
    for j = 1 : length(rrType)
        rrTypeVal = rrType(j);
        rrTypeVal = char(rrTypeVal);
        for k=1:length(AllRRType)
            if rrTypeVal == AllRRType(k)
                cnt = rrTypeEveryFile(i, k)+1;
                rrTypeEveryFile(i, k) = cnt;
                break;
            end
        end
    end
end