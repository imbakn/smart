#! /bin/bash

INSTALL_PATH=~/.smart

if [ ! -f $INSTALL_PATH/install.sh ] && [ ! -f $INSTALL_PATH/main.rc ] ; then
    mv ~/.smart ~/.smart.bak
    git clone https://github.com/imbakn/smart ~/.smart
fi

cd ~/.smart && git submodule init && git submodule update

# 安装 fzf
~/.smart/modules/fzf/install

[ -f ~/.bashrc ] && echo 'export SMART_SHELL=bash' >> ~/.bashrc
[ -f ~/.bashrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.bashrc

[ -f ~/.zshrc ] && echo 'export SMART_SHELL=zsh' >> ~/.zshrc
[ -f ~/.zshrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.zshrc


# 替换apt 源 安装 apt 软件
~/.smart/apt_install.sh

# 创建 dotfiles 链接
cd ~/.smart && stow dotfiles -t $HOME
