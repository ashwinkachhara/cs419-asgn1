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
    
#print X
t = [108,23,13,73,130,169,184,4,76,179,45,6,193,8,44,200,207,102,203,173,84,3,140,141,68,38,187,150,98,156,117,29,136,209,90,125,89,80,53,16,175,115,111,164,40,9,83,60,42,126,163,132,147,198,199,120,131,181,186,77,161,62,32,11,92,127,172,34,124,165,166,133,171,202,138,70,28,142,109,188,71,31,22,101,86,144,205,139,35,118,5,39,116,52,81,190,137,129,43,106,204,72,26,112,182,94,189,180,93]
tr = [192,54,59,51,10,97,55,143,146,110,65,66,185,1,128,47,67,49,159,197,99,107,95,58,114,12,149,148,123,134,82,157,17,88,25,48,158,119,20,19,194,104,56,195,74,75,96,176,162,183,69,151,14,174,18,113,167,2,168,46,160,152,170,196,21,91,37,201,121,208,78,61,206,103,15,30,41,178,155,87,153,24,154,27,100,145,191,122,36,7,85,64,63,105,57,177,135,79,50,33]

ytrain = [y[i-1] for i in tr]
ytest = [y[i-1] for i in t]
Xtrain = [X[i-1] for i in tr]
Xtest = [X[i-1] for i in t]

paramstr = '-s 13 -v 10 -q -c '
#Crossvalidation for each value of C 1/50 to 50
lim=50
s = [str(1.0/i) for i in range(1,lim+1)]
s = s + [str(i) for i in range(2,lim+1)]

cvlist = []
for val in s:
    prob = problem(ytrain, Xtrain)
    param1 = parameter(paramstr+val)
    m1 = train(prob, param1)
    x = [val, m1]
    cvlist.append(x)
    
cvlist.sort(key=lambda x:x[1])
#print cvlist
print '-------Optimal Value of C, trainingSetError using Crossvalidation--------'
C = cvlist[0][0]
trainError = cvlist[0][1]
print C, trainError

param2 = parameter('-s 13 -q -c '+str(C))
m2 = train(prob, param2)
print '-------Test-Data---------'
p_label, p_acc, p_val = predict(ytest, Xtest, m2)





