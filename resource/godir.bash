function godir() {
    if [[ -z "$1" ]]; then
        echo "Usage: godir <regex>"
        return
    fi

    mkdir -p $T/out
    FILELIST=$T/out/filelist

    if [[ ! -f $FILELIST ]]; then
        echo -n "Creating index..."
        (\cd $T; find . -wholename ./out -prune -o -wholename ./.repo -prune -o -type f > $FILELIST)
        echo " Done"
        echo ""
    fi
    local lines
    lines=$(\grep /"$1" $FILELIST | sed -e 's/\/[^/]*$//' | sort | uniq)
    
    select=$(echo "$lines" | fzf -1 -e -0)
    
    if [ x"$select" != "x" ];then
        cd  $T/$select
        echo "Go to Dir: "$select
        LAST_GODIR_FILE=$1
    fi
}

function gg()
{
    if [ x"LAST_GODIR_FILE" != "x" ];then
        if [ -f $LAST_GODIR_FILE ];then
            if [ $# = 1 ];then
                vim $LAST_GODIR_FILE +$1
            else
                vim $LAST_GODIR_FILE
            fi
        fi
    fi
}
