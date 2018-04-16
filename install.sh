#! /bin/bash

INSTALL_PATH=~/.smart

if [ ! -f $INSTALL_PATH/install.sh ] && [ ! -f $INSTALL_PATH/main.rc ] ; then
    mv ~/.smart ~/.smart.bak
    git clone https://github.com/imbakn/smart ~/.smart
    git clone https://github.com/imbakn/smart.personal ~/.smart/personal
    cd ~/.smart && git submodule init && git submodule update
fi

[ -f ~/.bashrc ] && echo 'export SMART_SHELL=bash' >> ~/.bashrc
[ -f ~/.bashrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.bashrc

[ -f ~/.zshrc ] && echo 'export SMART_SHELL=zsh' >> ~/.zshrc
[ -f ~/.zshrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.zshrc

# need to backup orignal files
# ln -s $INSTALL_PATH/dotfiles/.tmux ~/.tmux
# ln -s $INSTALL_PATH/dotfiles/.tmux.conf ~/.tmux.conf
# ln -s $INSTALL_PATH/dotfiles/.ideavimrc ~/.ideavimrc
# ln -s $INSTALL_PATH/personal/dotfiles/.tmuxinator ~/.tmuxinator
