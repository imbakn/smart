#! /bin/bash

function getdir() {
    mkdir -p $T/out
    FILELIST=$T/out/filelist

    if [[ ! -f $FILELIST ]]; then
        (\cd $T; find . -wholename ./out -prune -o -wholename ./.repo -prune -o -type f > $FILELIST)
    fi
    local lines
    lines=$(\grep /"$1" $FILELIST | sed -e 's/\/[^/]*$//' | sort | uniq)
    
    select=$(echo "$lines" | fzf -1 -e -0)
    
    if [ x"$select" != "x" ];then
        echo $T/$select
    fi
}


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
        NUMBER=$(echo $LINE | awk '{print $1}')
        
        if [[ $LINE =~ .*at.*\(.*\.java:[0-9]*\)  ]];then
            echo $LINE
            PACKAGENAME_REMOVELEFT=${LINE#" at "}
            PACKAGENAME=${PACKAGENAME_REMOVELEFT%\(*}
            CONTENT=${LINE#*$PACKAGENAME}
            FILENAME_REMOVELEFT=${CONTENT#\(}
            FILENAME=${FILENAME_REMOVELEFT%:*}
            echo FILENAME $FILENAME
            LINE_REMOVELEFT=${CONTENT#*:}
            LINENUM=${LINE_REMOVELEFT%\)}
            echo LINENUM $LINENUM
            FILEDIR=$(getdir $FILENAME)
            vim $FILEDIR/$FILENAME +$LINENUM
        else
            if [ x"$NUMBER" != "x" ]; then
                vim $1 +$NUMBER
            else
                break
            fi
        fi
        
    done
else
    echo "$1 is not a file.."
fi
