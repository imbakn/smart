#! /bin/bash

SEARCHSTR="Qualcomm"
if [ $# -gt 0 ];then
    SEARCHSTR=$1
fi

PIDUID=$(lsusb | grep $SEARCHSTR | awk '{print $6}')
VID=${PIDUID%:*}
echo "vid is : "$VID
PID=${PIDUID#*:}
echo "pid is : "$PID
echo "add this to /etc/udev/rules.d/70-android.rules"

sudo bash -c "echo \"SUBSYSTEM==\\\"usb\\\", ATTRS{idVendor}==\\\"$VID\\\", ATTRS{idProduct}==\\\"$PID\\\",MODE=\\\"0666\\\"\" >> /etc/udev/rules.d/70-android.rules"
TMPLIST=$(cat /etc/udev/rules.d/70-android.rules)
sudo bash -c "echo \"$TMPLIST\" | sort | uniq > /etc/udev/rules.d/70-android.rules"



