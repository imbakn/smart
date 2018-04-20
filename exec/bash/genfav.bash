#! /bin/bash
if [ x"$T" != "x" ] ;then
    cd $T
    find frameworks/base/ frameworks/av/ frameworks/native/ packages/ system/ device/ hardware/ vendor/huaqin external/ -name Android.mk -exec dirname {} \; | grep -v tests > "$T"/.myfavories
    cd -
else
    echo "env T is not set, please check it"
fi
