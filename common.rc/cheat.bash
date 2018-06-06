_cheat_autocomplete()
{
    COMPREPLY=()
    local word
    word="${COMP_WORDS[COMP_CWORD]}"

    if [ "$COMP_CWORD" -eq 1 ]; then
        local cheats="$(compgen -W "$(cheat list)" -- "$word")"
        COMPREPLY=( $cheats )
    fi
}


cheat_help()
{
    if [ $# = 0 ]; then
        cmd=$(cheat list | fzf -e)
        if [ x"$cmd" != "x" ];then
            cheat show $cmd
            LAST_CHEAT=$cmd
        fi
    elif [ $# = 1 ]; then
        if [ "$1" -gt 0 ] 2>/dev/null ;then
            if [ x"$LAST_CHEAT" != "x" ];then
                cheat show $LAST_CHEAT -c $1
            fi
        else
            cheat show $1
            LAST_CHEAT=$1
        fi
    fi
}


complete -F _cheat_autocomplete cheat_help h

alias h="cheat_help"
