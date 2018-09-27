
android_auto_jump()
{
    if [ -f "$T/.myfavories" ]
    then
        if [ $# != 0 ];then
            DIR=`cat $T/.myfavories | fzf -q "$*" -e -1`
        else
            DIR=`cat $T/.myfavories | fzf -e -1`
        fi
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
    if [ $# != 2 ];then
        usage
    else
        if [ ! -f ./build/envsetup.sh ]
        then
            usage
        else
            if [ -f ~/.android.projects/$PRO_NAME ]
            then
                echo "already has a project called this name."
                usage
            else
                if [ -f ~/.android.projects ]
                then
                    mv ~/.android.projects ~/.android.projects.bak
                fi

                if [ ! -d ~/.android.projects ]
                then
                    mkdir -p ~/.android.projects
                fi

                echo "init_android_project $PRO_PATH $PRODUCT_VARIANT" >> ~/.android.projects/$PRO_NAME

                export T=$PRO_PATH
                if [ ! -f .myfavories ]; then
                    genfav.bash
                fi
                echo "Project "$PRO_NAME" is created successed."
            fi
        fi
    fi
}

start_android_project()
{
    local PRO_NAME=$1
    if [ $# != 1 ]; then
        if [ x"$ANDROID_PROJECT" != "x" ]; then
            echo "Current Android Project is "$ANDROID_PROJECT
        else
            echo "usage: start_android_project project_name"
            echo "Project Name Could be: "$(ls ~/.android.projects)
        fi
    else
        if [ $1 = "-l" ]; then
            echo $(ls ~/.android.projects)
        else
            if [ -f ~/.android.projects/$PRO_NAME ];then
                source ~/.android.projects/$PRO_NAME
                aw
                source ~/.smart/resource/godir.bash
                ANDROID_PROJECT=$PRO_NAME
            else
                echo "The project Name is not right."
                echo "Project Name Could be: "$(ls ~/.android.projects)
            fi
        fi
    fi
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

get_ubuntu_version()
{
    lsb_release -r | awk '{print $2}'
}

#if [ x$(get_ubuntu_version) = x"18.04" ]
#then
#    export LC_ALL=C
#fi



alias cap=create_android_project
alias sap=start_android_project
