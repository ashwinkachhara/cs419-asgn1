# -*- coding: utf-8 -*-
"""
Created on Fri Sep 27 20:20:08 2013

@author: ashwin
"""

f = file('machine.data.txt')
machines = f.readlines()

allmachines = []

for machine in machines:
    data = machine.split(',')
    temp = {}
    temp['vendorname'] = data[0]
    temp['modelname'] = data[1]
    temp['myct'] = data[2]
    temp['mmin'] = data[3]
    temp['mmax'] = data[4]
    temp['cach'] = data[5]
    temp['chmin'] = data[6]
    temp['chmax'] = data[7]
    temp['prp'] = data[8]
    temp['erp'] = data[9]
    allmachines.append(temp)
    
print allmachines

