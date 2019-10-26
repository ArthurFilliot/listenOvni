#!/bin/bash
localaddress='xxx.xxx.xxx.xxx'
proxyaddress='xxx.xxx.xxx.xxx'
proxyport='xxxx'
sudo rm /var/log/listenOvni/info.log
notify-send 'begin'
while :
do
sudo tcpdump -nnn -A -l -i wls1 -c 1 -X \
"   (dst $proxyaddress   && src $localaddress       && not dst port $proxyport && not dst port 53 && not icmp) 
||  (src $proxyaddress   && dst $localaddress       && not src port $proxyport && not src port 53) 
||  (src $localaddress   && dst not $proxyaddress   && not dst port https) 
||  (dst $localaddress   && src not $proxyaddress   && not src port https) 
&& (not arp) 
&& (not dst 224.0.0.22 or 91.189.89.199)
&& (not port 1900) 
&& (not port 5353)" >> /var/log/listenOvni/info.log
notify-send 'Ovni detected'
sleep 5
done
