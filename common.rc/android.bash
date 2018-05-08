
android_auto_jump()
{
    if [ -f "$T/.myfavories" ]
    then
       DIR=`cat $T/.myfavories | fzf`
       if [ -d "$T/$DIR" ]
       then
          cd $T/$DIR
          cd ~
          cd -
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
