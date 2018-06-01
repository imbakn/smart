#! /bin/bash
if [ x"$T" != "x" ] ;then
    cd $T
    if [ $# -eq 0 ] ; then
        find frameworks/base/ frameworks/av/ frameworks/native/ packages/ system/ device/ hardware/ vendor/huaqin external/ -maxdepth 4 -name Android.mk -exec dirname {} \; | grep -v tests > "$T"/.myfavories
    else
        if [ -d $1 ];then
            find $1 -maxdepth 4 -name Android.mk -exec dirname {} \; | grep -v tests >> "$T"/.myfavories
        fi
    fi
    cd -
else
    echo "env T is not set, please check it"
fi
