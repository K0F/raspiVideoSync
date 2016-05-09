#!/bin/bash
source /home/pi/.bashrc
export PATH=$PATH:/usr/bin:/usr/local/bin:/sbin/


(mkfifo /tmp/ctl)&

#((/bin/nc -z -d -ul localhost -p7777) > /tmp/ctl)&

(sleep 10s &&  ssh -fN -R 9999:localhost:22 famuStrojGlobal -p5081)&

while true; do

running=$(head -1 /home/pi/running);

if [[ $running -eq "1" ]]; then
    (sleep 4s && omxplayer -o local -b --no-osd /home/pi/video.mp4)
else
    (sleep 1m)
fi

done




#(sleep 5s && omxplayer --loop --no-osd -b video.mp4 < /tmp/ctl)&

#(sleep 30s && /home/pi/send.sh)&
#(while true; do sleep 25m && sleep 13s && sh /home/pi/send.sh ;done)&

