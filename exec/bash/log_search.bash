#! /bin/bash

if [ $# -lt 1 ]; then
    echo "need to input a file."
    exit
fi

if [ -f $1 ]
then
    LINE=$(cat $1 | nl -b a | peco)
    NUMBER=$(echo $LINE | awk '{print $1}')
    vim $1 +$NUMBER
else
    echo "$1 is not a file.."
fi
