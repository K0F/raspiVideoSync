#!/bin/bash
source /home/pi/.bashrc
export PATH=$PATH:/usr/bin:/usr/local/bin:/sbin/

## CHECKDISK
(sudo touch /forcefsck)&

sleep 15s

## MAKE CONTROL FIFO
(mkfifo /tmp/ctl)&

ip2int()
{
    local a b c d
    { IFS=. read a b c d; } <<< $1
    echo $(((((((a << 8) | b) << 8) | c) << 8) | d))
}

int2ip()
{
    local ui32=$1; shift
    local ip n
    for n in 1 2 3 4; do
        ip=$((ui32 & 0xff))${ip:+.}$ip
        ui32=$((ui32 >> 8))
    done
    echo $ip
}

netmask()
{
    local mask=$((0xffffffff << (32 - $1))); shift
    int2ip $mask
}


broadcast()
{
    local addr=$(ip2int $1); shift
    local mask=$((0xffffffff << (32 -$1))); shift
    int2ip $((addr | ~mask))
}


IP=sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'

## ONE SHOT VARIANT
## LISTEN FOR SYNC
(while true; do ((/bin/nc -luw0 7777) >> /tmp/ctl) ; done)&
## PLAY ONCE
(omxplayer -b -o local --no-osd /home/pi/checker.mp4 < /tmp/ctl)&
## SENDER ONLY
#(sleep 30s && /home/pi/send.sh )&

#############################################################################
## LOOPING
#(while true; do sleep 25m && sleep 13s && sh /home/pi/send.sh ;done)&

#(while true; do (sleep 4s && omxplayer -b -o local --no-osd /home/pi/video.mp4 < /tmp/ctl)& (sleep 8m && sleep 13s && sh /home/pi/send.sh && sh /home/pi/send.sh) ; done)&



#(sleep 5s && omxplayer --loop --no-osd -b video.mp4 < /tmp/ctl)&


