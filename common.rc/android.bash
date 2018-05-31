
android_auto_jump()
{
    if [ -f "$T/.myfavories" ]
    then
       DIR=`cat $T/.myfavories | fzf`
       if [ -d "$T/$DIR" ]
       then
          cd $T/$DIR
       else
          vim $T/$DIR
       fi
    else
       echo "project is not set correctly."
    fi
}

init_android_project()
{
    local PRO_PATH=$1
    local PRODUCT_VARIANT=$2

    cd $PRO_PATH
    if [ -x out/host/linux-x86/bin/adb ]
    then
        chmod 666 out/host/linux-x86/bin/adb
    fi
    source ./build/envsetup.sh > /dev/null

    lunch $PRODUCT_VARIANT > /dev/null
    source $SMARTDIR/resource/init_android_env_var > /dev/null
}

usage()
{
    echo "you must run this command in a android project root dir."
    echo "usage create_android_project PRODUCT_NAME PRODUCT_VARIANT"
}


create_android_project()
{
    local PRO_NAME=$1
    local PRODUCT_VARIANT=$2
    local PRO_PATH=$(pwd)

    if [ ! -f ./build/envsetup.sh ]
    then
        usage
    fi

    if [ -f ~/.android.projects/$PRO_NAME ]
    then
        echo "already has a project called this name."
        usage
    fi

    if [ -f ~/.android.projects ]
    then
        mv ~/.android.projects ~/.android.projects.bak
    fi

    if [ ! -d ~/.android.projects ]
    then
        mkdir -p ~/.android.projects
    fi

    echo "init_android_project $PRO_PATH $PRODUCT_VARIANT" >> ~/.android.projects/$PRO_NAME
    alias $PRO_NAME="source ~/.android.projects/$PRO_NAME"   
}

start_android_project()
{
    local PRO_NAME=$1
    source ~/.android.projects/$PRO_NAME
}

_start_android_project() {
    COMPREPLY=()
    local word
    word="${COMP_WORDS[COMP_CWORD]}"

    if [ "$COMP_CWORD" -eq 1 ]; then
        local projects="$(compgen -W "$(ls ~/.android.projects)" -- "$word")"

        COMPREPLY=( $commands $projects )
    fi
}
complete -F _start_android_project start_android_project sap


alias cap=create_android_project
alias sap=start_android_project
