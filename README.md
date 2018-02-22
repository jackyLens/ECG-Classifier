# ECG-Classifier

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/1.gif)

The six electrocardiogram (ecg) waveforms that are important in physiology are classified by this classifier. 

- normal beat
- atrial premature beat
- paced beat
- premature ventricular beat
- paced beat
- premature ventricular beat
- left bundle branch block beat
- right bundle branch block beat

## Innovative Pionts

The electrocardiogram is very complicated on the waveform, and it is easy to be disturbed by the outside environment which results in the poor accuracy rate of wave positioning. However, the current classification method needs to correctly detect the position of P wave, Q wave, R wave, S wave and T wave, then extract the spacing between wave and wave and the amplitude of the wave as characteristics. These methods are complex and generally not accurate.

Our method extracts the characteristics needed for classification by positioning the R wave which is the most obvious characteristics in the electrocardiogram. Using wavelet transform and other methods, the accuracy rate of positioning the R wave can reach 99.99%. Our method is clear, and the realization process is simple.

## Classification results

Our classification accuracy was 98.58%, which was significantly improved compared with most classifiers.

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/result-chart.png)

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/result-table.png)

# Database

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/ecg.png)

The ecg data were obtained from the [MIT-BIH Arrhythmia Database](https://www.physionet.org/physiobank/database/mitdb/) which contains the following three types of data:

- Annotations：Category information with manual annotation, and R wave position.
- Signals：Waveform data file.
- Header：Other information.

Annotations Data and Signals Data is binary. You can install the official WFDB software toolkit to transform these binary files into text files.

## rdsamp

Used to transform the Signals files into text files.

```
rdsamp -r mitdb/200 -f 5:0 -t 10:30 -p -v >200.txt
```

```
time MLII V1
(sec) (mV) (mV)
300.000 -0.095 -0.140
300.003 -0.110 -0.140
300.006 -0.110 -0.120
300.008 -0.115 -0.110
300.011 -0.115 -0.120
300.014 -0.110 -0.110
300.017 -0.100 -0.120
```

## rdann

Used to transform the Annotations files into text files.

```
rdann -r mitdb/200 -a atr -f 5:10 -t 10:30 -v >200.txt
```

```
 Time       Sample     #   Type Sub  Chan   Num      Aux
 5:10.277   111700     N    0    0    0
 5:10.838   111902     N    0    0    0
 5:11.391   112101     N    0    0    0
 5:11.961   112306     N    0    0    0
 5:12.525   112509     N    0    0    0
 5:13.155   112736     N    0    0    0
 5:13.480   112853     +    0    0    0      (B
 5:13.805   112970     V    1    0    0
 5:14.461   113206     N    0    0    0
 5:15.011   113404     V    1    0    0
 5:15.658   113637     N    0    0    0
```

## Pre-Processing

### Smoothing Filtering

Used to remove the interference of labor frequency. The interference performance as small burr in electrocardiogram, which is caused by the 50Hz alternating current and its multiple harmonics.

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/noise.png)

### Baseline offset filtering

Used to remove baseline offset. Baseline shift is caused by motion of the human body and the electrode foundation bad noise, motion artifact and click contact caused by breathing, in ecg waveform to overlay a slow variation.

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/line_drift.png)

## Implementation

Our method directly uses the R wave information manually labeled in the data.

### Waveform Interception

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/wave.png)

### Similarity Measurement

### Bag Decision Tree

The bagged decision tree provided by the Statistics and Machine Learning Toolbox of MatLab was used to classify.