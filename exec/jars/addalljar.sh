#!/bin/bash

SMART_JAR_PATH=$SMARTDIR/exec/jars

for jar in $(ls $SMART_JAR_PATH/*.jar)
do
   runjar.sh $SMART_JAR_PATH/$jar
done
