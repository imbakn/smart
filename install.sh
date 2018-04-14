#! /bin/bash
# mv ~/.smart ~/.smart.bak
# git clone https://github.com/imbakn/smartcmd ~/.smart

echo 'export SMART_SHELL=bash' >> ~/.bashrc
echo '[ -f ~/.smart/main.rc ] && source ~/.smart/main.rc' >> ~/.bashrc
