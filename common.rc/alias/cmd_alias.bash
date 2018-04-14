alias c='cd'
alias g='gedit'
alias v='vim'
alias p='psf'
alias b='bcompare'

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
alias jj='source $SMARTDIR/resource/android_auto_jump'
alias mux='tmuxinator'
