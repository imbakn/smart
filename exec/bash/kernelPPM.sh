#! /bin/bash
pngtopnm $1 > /tmp/$1.pnm
pnmquant 224 /tmp/$1.pnm > /tmp/$1.224.pnm
pnmtoplainpnm /tmp/$1.224.pnm > $1.ppm
