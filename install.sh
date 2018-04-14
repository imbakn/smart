#! /bin/bash
# mv ~/.smart ~/.smart.bak
# git clone https://github.com/imbakn/smartcmd ~/.smart
# git clone https://github.com/imbakn/smart.personal ~/.smart/personal

INSTALL_PATH=~/.smart

[ -f ~/.bashrc ] && echo 'export SMART_SHELL=bash' >> ~/.bashrc
[ -f ~/.bashrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.bashrc

[ -f ~/.zshrc ] && echo 'export SMART_SHELL=zsh' >> ~/.zshrc
[ -f ~/.zshrc ] && echo "[ -f $INSTALL_PATH/main.rc ] && source $INSTALL_PATH/main.rc" >> ~/.zshrc

# need to backup orignal files
# ln -s $INSTALL_PATH/configs/tmux/.tmux ~/.tmux
# ln -s $INSTALL_PATH/configs/tmux/.tmux.conf ~/.tmux.conf
# ln -s $INSTALL_PATH/personal/.tmuxinator ~/.tmuxinator
