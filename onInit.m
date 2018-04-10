pkg load instrument-control
s1 = serial("/dev/ttyUSB0", 115200)
srl_flush(s1)
delay = 0.22

while 1
  data = srl_read(s1, 1)
  if data == "s"
    sleep(delay)
    srl_write(s1, "PRUSA thx\n")
  endif
endwhile