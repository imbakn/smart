#! /bin/bash

get_ubuntu_version()
{
    lsb_release -r | awk '{print $2}'
}

do_backup() {
    if [ -e "$1" ]; then
        msg "Attempting to back up your apt source list"
        today=`date +%Y%m%d_%s`
        [ -e "$1" ] && [ ! -L "$1" ] && sudo mv -v "$1" "$i.$today";
        ret="$?"
        success "Your original apt sourcelist has been backed up."
   fi
}

if [ x$(get_ubuntu_version) = x"12.04" ]
then
    do_backup /etc/apt/sources.list
    sudo cp ~/.smart/resource/apt_source_1204_163.list /etc/apt/sources.list
fi

sudo apt-get install python3
sudo apt-get install ruby
sudo apt-get install stow
sudo apt-get install neovim
sudo apt-get install tmux
sudo apt-get install watch
