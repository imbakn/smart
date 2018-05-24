#! /bin/bash

if [ $# -lt 1 ]; then
    echo "need to input a file."
    exit
fi

if [ -f $1 ]
then
    cat $1 | nl | peco
else
    echo "$1 is not a file.."
fi
