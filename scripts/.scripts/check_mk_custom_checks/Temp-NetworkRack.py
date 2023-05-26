#!/usr/bin/python3
# -*- coding: utf-8 -*-
###edit this
# Temperaturüberwachung mit DS18B20 und Raspberry PI (Gpio Pin 4)
# Lokaler Check für Check_MK
# Bei installiertem Check_MK Agent das Skript unter "/usr/lib/check_mk_agent/local" ablegen
sensorname = "Temp-NetworkRack0"
minwarn = 10.0
mincrit = 5.0
maxwarn = 38.0
maxcrit = 40.0
file = open("/sys/bus/w1/devices/28-3c01e076278d/w1_slave")
###stop editing here
 
fileLines = file.readlines()
file.close()
 
count = 0
crc = 0
for line in fileLines:
  count += 1
  if count == 1:
    if line.strip().endswith('YES'):
       crc = 1
  if count == 2:
    if crc == 1:
       pos = line.strip().find('t=')
       temp1 = line.strip()[pos+2:]
       templen = 5 - len(temp1)
       temp = temp1[:2-templen] + "." + temp1[2-templen:]
       state = "P"
       stateext = "OK"
       if float(temp) < minwarn:
         state = "1"
         stateext = "WARN"
       if float(temp) < mincrit:
         state = "2"
         stateext = "CRIT"
       if float(temp) >= maxwarn:
         state = "1"
         stateext = "WARN"
       if float(temp) >= maxcrit:
         state = "2"
         stateext = "CRIT"
       print("{} {} temp={};{};{};{};{} {} – Temp {} °C".format(state,sensorname,temp,maxwarn,maxcrit,mincrit,maxcrit,stateext,temp))
    else:
       print("3 temp=0 Unknown – Wiring problem with sensor")
