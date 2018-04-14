#! /bin/bash
SSID=$1
PASS=$2
INDEX=$3

echo "SSID:"$SSID   PASS:$PASS  INDEX:$INDEX
#/sbin/wpa_supplicant -B -P /run/sendsigs.omit.d/wpasupplicant.pid -u -s -O /var/run/wpa_supplicant
wpa_cli add_network 0 
wpa_cli set_network 0 ssid \"$SSID\"
wpa_cli set_network 0 psk \"$PASS\"
wpa_cli select_network 0



