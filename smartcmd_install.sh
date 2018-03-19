#! /bin/bash
# mv ~/.smartcmd ~/.smartcmd.bak
# git clone https://github.com/imbakn/smartcmd ~/.smartcmd



echo 'SHPATH=~/.smartcmd/bashrc
for list in $(ls $SHPATH) 
do
   source $SHPATH/$list
done' >> ~/.bashrc

