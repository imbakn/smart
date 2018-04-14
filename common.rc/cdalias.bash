#! /bin/bash
upnum()
{
	echo `echo "../" | awk -v num=$1 '{for(i=1;i<=num;i++) printf($0)}'`;
}

for ((index=0; index<10; ++index))
do
    newdir=$(upnum $index);
	eval D$index=$(upnum $index);
    alias cd$index="cd $newdir";
done
