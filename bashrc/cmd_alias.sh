alias c='cd'
alias b='bcompare'
alias v='f -e vim'

##################################################
alias hexd="hexdump -v -e '1/1 \"%02x \"' "
alias lower="tr [A-Z] [a-z]"
alias upper="tr [a-z] [A-Z]"



#################################################
alias rmt="adb remount"
alias rbt="adb reboot"
alias shl="adb shell"
alias log="adb logcat"
alias push="adb push"
alias pull="adb pull"


#################################################
alias t='[ -z "$T" ] || eval "cd $T"'
alias jj='source ~/.smartcmd/source/android_auto_jump'
