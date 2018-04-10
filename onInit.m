#!/usr/bin/octave -f
pkg load instrument-control
s1 = serial("/dev/ttyUSB0", 115200)
srl_flush(s1)
delay = 0.22
do 
  data = srl_read(s1, 1)
until ('s' == data(1))
pause(delay)
srl_write(s1, "PRUSA thx\n")