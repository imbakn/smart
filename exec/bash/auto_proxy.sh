#! /bin/bash

#http://xduotai.com/pT0CakQElc.pac
if (( $# < 2 ))
then
    echo "*****************************USAGES********************************"
    echo "***   copy auto_proxy.sh to /usr/bin"
    echo "***   use like this: \"auto_proxy.sh pacfile sec\""
    echo "*××   eg: \"auto_proxy.sh http://xduotai.com/pT0CakQElc.pac  1200 &\""
    echo "*******************************************************************"
    exit
fi
 
resetProxy()
{
    gsettings set org.gnome.system.proxy mode 'none'
    gsettings set org.gnome.system.proxy mode 'auto'
    gsettings set org.gnome.system.proxy autoconfig-url $1

}

while true
do
    resetProxy $1
    sleep $2
done


