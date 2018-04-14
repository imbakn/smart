#! /bin/bash
# mv ~/.smart ~/.smart.bak
# git clone https://github.com/imbakn/smartcmd ~/.smart
# git clone https://github.com/imbakn/smart.personal ~/.smart/personal

[ -f ~/.bashrc ] && echo 'export SMART_SHELL=bash' >> ~/.bashrc
[ -f ~/.bashrc ] && echo '[ -f ~/.smart/main.rc ] && source ~/.smart/main.rc' >> ~/.bashrc

[ -f ~/.zshrc ] && echo 'export SMART_SHELL=zsh' >> ~/.zshrc
[ -f ~/.zshrc ] && echo '[ -f ~/.smart/main.rc ] && source ~/.smart/main.rc' >> ~/.zshrc
