#! /bin/bash

PACKAGENAME=`adb shell pm list packages| awk -F: '{print $2}' | fzf`
if [ ! -z $PACKAGENAME ]
then
    adb shell pm uninstall $PACKAGENAME
else
    echo "error"
fi


