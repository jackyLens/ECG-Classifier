% 加载模版数据
% 每种类别取 NumOfTamplet 个模版
display('loadTampletWaves...');
tampletWaves = cell(NumOfRRType, 3 * NumOfTamplet);
getTampletWaveCntEveryFile;
curCnt = zeros(length(AllFileNumber), NumOfRRType);
tampletWavesIndex = ones(NumOfRRType, 1);
for i = 1 : length(AllFileNumber)
    hasFindAll = 1;
    for j = 1 : NumOfRRType
        if curCnt(i, j) ~= tampletWaveCntEveryFile(i, j)
            hasFindAll = 0;
            break;
        end
    end
    if hasFindAll
        continue;
    end
    [rrWave, rrType, ~] = loadRRFile(AllFileNumber(i));
    [waveData, ~] = loadDatFile(AllFileNumber(i));
    [lwaves, rwaves] = cutWave(rrWave, LenOfWave);
    p = randperm(length(rrWave));
    rrWave = rrWave(p);
    rrType = rrType(p);
    for j = 3 : length(rrType) - 2
        if isKey(RRTypeMap, rrType(j))
%         if isStrMatrixContain(AllRRType, char(rrType(j)))
            for k = 1 : NumOfRRType
                if AllRRType(k) == char(rrType(j)) && curCnt(i, k) < tampletWaveCntEveryFile(i, k)
                    curCnt(i, k) = curCnt(i, k) + 1;
                    tampletWaves { k, 3 * (tampletWavesIndex(k) - 1) + 1 } = waveData(rwaves(j - 1): lwaves(j));
                    tampletWaves { k, 3 * (tampletWavesIndex(k) - 1) + 2 } = waveData(lwaves(j): rwaves(j));
                    tampletWaves { k, 3 * (tampletWavesIndex(k) - 1) + 3 } = waveData(rwaves(j): lwaves(j + 1));
                    tampletWavesIndex(k) = tampletWavesIndex(k) + 1;
                    break;
                end
            end
        end
    end
end