#!/usr/bin/env python

import csv
import os
import scipy.io
import sys

file_name = sys.argv[1]

matrix = scipy.io.loadmat(file_name)

with open(file_name.replace('mat', 'csv'), 'wb') as csvfile:
  spamwriter = csv.writer(csvfile, delimiter=';', quotechar='\n')

  for line in matrix['QWADglobal']:
    spamwriter.writerow(list(line))
