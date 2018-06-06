#! /bin/bash

SERVICE=$(adb shell dumpsys -l  | fzf -e)
if [ $1 = '-w' ]
then
    watch adb shell dumpsys $SERVICE
else
    adb shell dumpsys $SERVICE
fi
