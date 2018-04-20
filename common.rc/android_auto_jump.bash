
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
