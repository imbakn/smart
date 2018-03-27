#!/bin/bash
get_current_dir()
{
	SOURCE="$0"
	while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
	    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
	    SOURCE="$(readlink "$SOURCE")"
	    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
	echo $DIR
}

CDIR=$(get_current_dir $0)
echo CDIR:$CDIR
CALLNAME=`basename $0`
echo CALLNAME:$CALLNAME
echo `pwd`
HASLINK=`ls -n $0 | awk '{print $10}'`
echo HASLINK:$HASLINK
if [ -z $HASLINK ] || [[ `basename $HASLINK` == $CALLNAME ]]
then
#create a link for jar file
	PARAM1=$1
	SUFFIX=${PARAM1##*.}
	JARNAME=`basename -s .jar $PARAM1`
	WJARPATH=$CDIR"/"$JARNAME".jar"
	echo ============
	echo $#
	echo "$WJARPATH"
	echo $SUFFIX
	echo ============
	if [  $# -lt  1 ] || [[ $SUFFIX != "jar" ]] || [ ! -f "$WJARPATH" ]
	then
		echo "usage: $CALLNAME _path_of_jar_"
	else
		echo  $CDIR"/"$CALLNAME link to /usr/bin/$JARNAME
		sudo ln -s $CDIR"/"$CALLNAME /usr/bin/$JARNAME
	fi
else
#call the jar file
	java -jar $CDIR/$CALLNAME".jar" $@
fi



