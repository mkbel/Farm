#!/usr/bin/octave -f
pkg load instrument-control
s1 = serial("/dev/ttyUSB1", 115200)
srl_flush(s1)
lag = 0.005
delay = 0.23

do 
  data = srl_read(s1, 1)
until ('s' == data(1))
# pause(delay-lag)
#srl_write(s1, "PRUSA thx\n")
# pause(1.001)
# pause(1.033)
pause(1.0)
srl_write(s1, "PRUSA SN\n")
pause(3.0)
srl_write(s1, "PRUSA thx\n")
