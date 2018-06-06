#! /bin/bash

if [ $# -lt 1 ]; then
    echo "need to input a file."
    exit
fi

if [ -f $1 ]
then
    while :
    do
        if [ x"$QUERY" = "x" ];then
            CONTENT=$(cat $1 | nl -b a | fzf --height 100 -e  --prompt=search: --border +s --print-query)
        else
            CONTENT=$(cat $1 | nl -b a | fzf --height 100 -e  --prompt=search: --border +s --print-query -q "$QUERY")
        fi
        LINE=$(echo "$CONTENT" | sed -n '2p')
        QUERY=$(echo "$CONTENT" | sed -n '1p')
        echo LINE $LINE
        echo QUERY $QUERY
        NUMBER=$(echo $LINE | awk '{print $1}')
        echo NUMBER $NUMBER
        if [ x"$NUMBER" != "x" ]; then
            vim $1 +$NUMBER
        else
            break
        fi
    done
else
    echo "$1 is not a file.."
fi
