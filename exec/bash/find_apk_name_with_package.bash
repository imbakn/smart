#! /bin/bash
PACKAGENAME=$1

PID=`adb shell ps | grep $PACKAGENAME | awk '{print $2}'`
if [ x"$PID" = "x" ];then
    echo "Process is not running. please check it."
    exit
fi
APPPATH=`adb shell "cat /proc/$PID/maps" | grep 'app' | grep '\.apk' | awk '{print $6}' | sort | uniq`
if [ x"$APPPATH" = "x" ];then
    echo "Can not find APPPATH."
    exit
fi
echo "The App path is : " $APPPATH

