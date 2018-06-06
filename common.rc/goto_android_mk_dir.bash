#! /bin/bash

upnum()
{
	echo `echo "../" | awk -v num=$1 '{for(i=1;i<=num;i++) printf($0)}'`;
}

a()
{
    for index in {1..20}
    do
        PPP=$(upnum $index)
        if [ -f $PPP"Android.mk" ];then
            cd $PPP
            break
        fi
    done
}
