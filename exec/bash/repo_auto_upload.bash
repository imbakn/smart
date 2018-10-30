#! /bin/bash

git add "$@"
echo ============$UPLOAD_TYPE
projectName=$(git config --get remote.gerrit.projectname)
rawName=${projectName##*/}
PNAME=$(cat $T/.project.name)
FIX_PROJECT_NAME="["$rawName"]"
FIX_TYPE_BUG="[BUG]"
FIX_TYPE_FEATURE="[FEATURE]"
FIX_TYPE=$FIX_TYPE_FEATURE
if [ x"$UPLOAD_TYPE" = "xbug" ]
then
    FIX_TYPE=$FIX_TYPE_BUG
fi
FIX_PNAME="["$PNAME"]"
WHOLE_NAME=$FIX_PNAME$FIX_TYPE$FIX_PROJECT_NAME
git commit -e -m "$WHOLE_NAME" && repoupload

