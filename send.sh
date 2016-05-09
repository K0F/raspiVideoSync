#!/bin/bash
#source /home/pi/.bashrc
export PATH=$PATH:/usr/bin:/usr/local/bin:/sbin/

(sleep 1s && echo -n p | /usr/bin/socat - UDP4-DATAGRAM:239.1.1.250:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:239.1.1.250:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:239.1.1.250:7777,so-broadcast)&
(sleep 2s && echo -n i | /usr/bin/socat - UDP4-DATAGRAM:239.1.1.250:7777,so-broadcast)&
(sleep 3s && echo -n p | /usr/bin/socat - UDP4-DATAGRAM:239.1.1.250:7777,so-broadcast)&
