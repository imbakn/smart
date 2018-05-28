#! /bin/bash

adb tcpip 5555
adb connect $1
export ANDROID_SERIAL="$1:5555"
