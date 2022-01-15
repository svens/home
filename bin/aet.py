#!/usr/local/bin/python3

# Original work https://github.com/marcoalt/Colab

"""
pip3 install fitparse
pip3 install plotnine
pip3 install scikit-learn
"""

import sys
import csv
import fitparse
import numpy
import pandas
import math
from sklearn.linear_model import LinearRegression

def DFA(pp_values, lower_scale_limit, upper_scale_limit):
    scaleDensity = 30
    m = 1

    start = numpy.log(lower_scale_limit) / numpy.log(10)
    stop = numpy.log(upper_scale_limit) / numpy.log(10)
    scales = numpy.floor(numpy.logspace(numpy.log10(math.pow(10, start)), numpy.log10(math.pow(10, stop)), scaleDensity))
    F = numpy.zeros(len(scales))
    count = 0

    for s in scales:
        rms = []
        x = pp_values
        y_n = numpy.cumsum(x - numpy.mean(x))
        L = len(x)
        shape = [int(s), int(numpy.floor(L/s))]
        nwSize = int(shape[0]) * int(shape[1])
        Y_n1 = numpy.reshape(y_n[0:nwSize], shape, order="F")
        Y_n1 = Y_n1.T
        Y_n2 = numpy.reshape(y_n[len(y_n) - (nwSize):len(y_n)], shape, order="F")
        Y_n2 = Y_n2.T
        Y_n = numpy.vstack((Y_n1, Y_n2))

        for cut in numpy.arange(0, 2 * shape[1]):
            xcut = numpy.arange(0, shape[0])
            pl = numpy.polyfit(xcut, Y_n[cut,:], m)
            Yfit = numpy.polyval(pl, xcut)
            arr = Yfit - Y_n[cut,:]
            rms.append(numpy.sqrt(numpy.mean(arr * arr)))

        if (len(rms) > 0):
            F[count] = numpy.power((1 / (shape[1] * 2)) * numpy.sum(numpy.power(rms, 2)), 1/2)
        count = count + 1

    pl2 = numpy.polyfit(numpy.log2(scales), numpy.log2(F), 1)
    alpha = pl2[0]
    return alpha


def computeFeatures(df):
  features = []
  step = 120
  x = df['timestamp']
  for index in range(0, int(round(numpy.max(x)/step))):
      array_rr = df.loc[(x >= (index*step)) & (x <= (index+1)*step), 'RR']*1000
      heartrate = round(60000/numpy.mean(array_rr), 2)
      NNdiff = numpy.abs(numpy.diff(array_rr))
      rmssd = round(numpy.sqrt(numpy.sum((NNdiff * NNdiff) / len(NNdiff))), 2)
      sdnn = round(numpy.std(array_rr), 2)
      alpha1 = DFA(array_rr.to_list(), 4, 16)

      curr_features = {
          'timestamp': index,
          'heartrate': heartrate,
          'rmssd': rmssd,
          'sdnn': sdnn,
          'alpha1': alpha1,
      }

      features.append(curr_features)

  features_df = pandas.DataFrame(features)
  return features_df


def main(filename):
    logger_file = pandas.read_csv(filename)
    RRs = logger_file.iloc[:, 1]/1000
    RRs = RRs.tolist()

    filtered_RRs = []
    for i in range(len(RRs)):
        if RRs[(i - 1)]*0.95 < RRs[i] < RRs[(i - 1)]*1.05:
            filtered_RRs.append(RRs[i])

    df = pandas.DataFrame()
    df['timestamp'] = numpy.cumsum(filtered_RRs)
    df['RR'] = filtered_RRs
    features_df = computeFeatures(df)

    length = len(features_df['alpha1'])
    reg = LinearRegression().fit(features_df['alpha1'].values.reshape(length, 1), features_df['heartrate'].values.reshape(length, 1))
    print(math.floor(reg.predict(numpy.array(0.75).reshape(1, 1))))


if __name__ == "__main__":
    main(sys.argv[1])
