datNumber = 100;
[waveData, orignalWaveData] = loadDatFile(datNumber);
t = 1 : length(waveData);
figure
plot(t, orignalWaveData, 'b', t, waveData, 'r')
grid on
axis tight
xlabel('Samples')
ylabel('Voltage(mV)')
legend('Noisy ECG Signal', 'Filtered Signal')
title('Filtering Noisy ECG Signal')