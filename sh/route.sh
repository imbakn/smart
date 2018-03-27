sudo route add -net 192.168.70.0 netmask 255.255.255.0 dev ppp0
sudo route add -net 74.125.0.0 netmask 255.255.0.0 dev ppp0
sudo route add -net 31.13.0.0 netmask 255.255.0.0 dev ppp0

sudo route add default gw 192.168.1.250


#www.facebook.com 31.13.76.102
#www.youtube.com 74.125.239.41

