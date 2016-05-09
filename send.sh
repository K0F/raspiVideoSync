#!/bin/bash
#source /home/pi/.bashrc
export PATH=$PATH:/usr/bin:/usr/local/bin:/sbin/

BR=`sudo ifconfig | grep Bcast | awk '{print $3}' | tr -d 'Bcast:'`
(echo broadcast: $BR >> /home/pi/log.txt)&

(sleep 1s && echo -n p | /usr/bin/socat - UDP4-DATAGRAM:$BR:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:$BR:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:$BR:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:$BR:7777,so-broadcast)&
(sleep 3s && echo -n p | /usr/bin/socat - UDP4-DATAGRAM:$BR:7777,so-broadcast)&
