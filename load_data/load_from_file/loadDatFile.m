function [ waveData, origWaveData ] = loadDatFile( datNumber )
% 加载一个dat文件
filename = fullfile('data', 'dattf', [num2str(datNumber), '.dat']);
fileID = fopen(filename, 'r');
C = textscan(fileID, '%s %f %f');
origWaveData = C{2};
fclose(fileID);
%% 平滑处理
waveData = smooth(origWaveData); 
waveData = waveData' ;
origWaveData = origWaveData' ;
%% 基线偏移处理
%waveData=detrend(waveData);
[p,~,mu] = polyfit((1:numel(waveData)), waveData, 6);
f_y = polyval(p, (1:numel(waveData)), [], mu);
waveData = waveData - f_y; 
end

