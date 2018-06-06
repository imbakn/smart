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
    
    select=$(echo "$lines" | fzf)
    
    if [ x"$select" != "x" ];then
        cd  $select
    fi
}
