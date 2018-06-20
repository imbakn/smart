#! /bin/bash

upnum()
{
	echo `echo "../" | awk -v num=$1 '{for(i=1;i<=num;i++) printf($0)}'`;
}

goto_mk_dir()
{
    for index in {1..20}
    do
        PPP=$(upnum $index)
        if [ -f $PPP"Android.mk" ];then
            DPATH=$(cd $PPP && pwd)
            DDPATH=${DPATH#$T/}
            echo "Go to Dir: "$DDPATH
            cd $PPP
            break
        fi
    done
}
