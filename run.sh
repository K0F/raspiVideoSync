#!/bin/bash
source /home/pi/.bashrc
export PATH=$PATH:/usr/bin:/usr/local/bin:/sbin/


## CHECKDISK
(sudo touch /forcefsck)&

sleep 10s

(cd /home/pi/raspiVideoSync && git pull)&

## MAKE CONTROL FIFO
(mkfifo /tmp/ctl)&
## ONE SHOT VARIANT
## LISTEN FOR SYNC
(while true; do ((/bin/nc -luw0 7777) >> /tmp/ctl) ; done)&
## PLAY ONCE
(omxplayer -b --loop --no-osd /home/pi/raspiVideoSync/checker.mp4 < /tmp/ctl)&
## SENDER ONLY
(sleep 30s && /home/pi/raspiVideoSync/send.sh )&

#############################################################################
## LOOPING
#(while true; do sleep 25m && sleep 13s && sh /home/pi/send.sh ;done)&

#(while true; do (sleep 4s && omxplayer -b -o local --no-osd /home/pi/video.mp4 < /tmp/ctl)& (sleep 8m && sleep 13s && sh /home/pi/send.sh && sh /home/pi/send.sh) ; done)&



#(sleep 5s && omxplayer --loop --no-osd -b video.mp4 < /tmp/ctl)&


