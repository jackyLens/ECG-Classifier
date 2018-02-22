# ECG-Classifier



对生理学上比较重要的六种心电图波形进行分类，这六种心电图波形分别为正常波形（normal beat）、心房早搏（atrial premature beat）、起搏（paced beat），室性早搏（premature ventricular beat）、左束支阻滞（left bundle branch block beat）和右束支阻滞（right bundle branch block beat）。

# 创新点

心电图在波形上很复杂，而且容易受到外界干扰，导致了对心电图进行准确定位的效果不佳。但是目前的分类方法基本上需要先正确检测出 P 波、Q 波、R 波、S 波和 T 波的位置，再提取波与波之间的间距和波的振幅作为特征，这些方法实现复杂，并且准确率普遍不高。

本方法可以在对心电图中具有最明显特征的 R 波进行定位之后就可以提取出分类所需要的特征，如今使用小波变换等方法对心电图波形中具有最明显特征的 R 波进行定位的准确率可以达到 99.99%。不仅如此，本方法通过 R 波提取特征的过程简洁明了，实现过程也很简单。

# 分类效果

最终分类准确率为 98.58%，相比于大多数分类器来说都有明显的提高。

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/result-chart.png)

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/result-table.png)

# 数据

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/ecg.png)

从 [MIT-BIH Arrhythmia Database](https://www.physionet.org/physiobank/database/mitdb/) 获取心率失常心电图数据，其中包含以下三种类别的数据：

- Annotations：包含了手工注释的类别信息，以及 R 波位置；
- Signals：波形数据文件；
- Header：其它信息。

Annotations 和 Signals 数据为二进制文件，为了方便处理，可以安装官方提供的 WFDB 软件工具包转换为文本文件。

## rdsamp

用于转换 Signals 文件为文本文件。

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

转换 Annotations 文件为文本文件

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

# 预处理

## 平滑滤波

用于去除工频干扰。工频干扰在心电图波形上表现为微小的毛刺，是由于50Hz交流电及其多次谐波引起的。

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/noise.png)

## 基线偏移滤波

用于去除基线偏移。基线偏移是由于人体的微动与电极基础不良引起的点击接触噪声、运动伪迹和由于呼吸引起的，在心电图波形上表现为叠加的一个缓慢变化量。

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/line_drift.png)

# 分类器实现

本方法不进行 R 波的定位，而是直接使用数据中手工标注的 R 波信息。

## 波形截取

截取一个心电图的 R 波左侧 RR<sub>a</sub> / 3 的位置到 R 波右侧 RR<sub>b</sub> / 3 的位置作为一个心电图的波形数据，而不需要对其它更多波形进行定位。

![](https://github.com/CyC2018/ECG-Classifier/blob/master/Pics/wave.png)

## 相似性度量

论文发表之后再公开。

## 袋装决策树

把数据七三划分，使用 MatLab 的 Statistics and Machine Learning Toolbox 提供的袋装决策树进行分类和测试。
