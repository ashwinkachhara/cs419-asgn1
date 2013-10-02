# -*- coding: utf-8 -*-
"""
Created on Fri Sep 27 20:20:08 2013

@author: ashwin
"""
from liblinearutil import *

f = file('machine.data.txt')
indata = f.readlines()

X = []
y = []
for machine in indata:
    data = machine.split(',')
#    temp = {}
#    temp['vendorname'] = data[0]
#    temp['modelname'] = data[1]
#    temp['myct'] = data[2]
#    temp['mmin'] = data[3]
#    temp['mmax'] = data[4]
#    temp['cach'] = data[5]
#    temp['chmin'] = data[6]
#    temp['chmax'] = data[7]
#    temp['prp'] = data[8]
#    temp['erp'] = data[9]
#    machines.append(temp)
#   instead of that, lets make a list of all predictive parameters itelf in the following order
#   myct, mmin, mmax, cach, chmin, chmax
    temp = [float(data[2]), float(data[3]), float(data[4]), float(data[5]), float(data[6]), float(data[7])]
    X.append(temp)
    y.append(float(data[8]))
    
##print X
#test = [108,23,13,73,130,169,184,4,76,179,45,6,193,8,44,200,207,102,203,173,84,3,140,141,68,38,187,150,98,156,117,29,136,209,90,125,89,80,53,16,175,115,111,164,40,9,83,60,42,126,163,132,147,198,199,120,131,181,186,77,161,62,32,11,92,127,172,34,124,165,166,133,171,202,138,70,28,142,109,188,71,31,22,101,86,144,205,139,35,118,5,39,116,52,81,190,137,129,43,106,204,72,26,112,182,94,189,180,93]
#train = [192,54,59,51,10,97,55,143,146,110,65,66,185,1,128,47,67,49,159,197,99,107,95,58,114,12,149,148,123,134,82,157,17,88,25,48,158,119,20,19,194,104,56,195,74,75,96,176,162,183,69,151,14,174,18,113,167,2,168,46,160,152,170,196,21,91,37,201,121,208,78,61,206,103,15,30,41,178,155,87,153,24,154,27,100,145,191,122,36,7,85,64,63,105,57,177,135,79,50,33]
#
#ytrain = []
#Xtrain = []
#for index in train:
#    ytrain.append(y[index-1])
#    Xtrain.append(X[index-1])
#ytest = []
#Xtest = []
#for index in test:
#    ytest.append(y[index-1])
#    Xtest.append(X[index-1])

prob = problem(y, X)
param = parameter('-s 13')

model = train(prob, param)




