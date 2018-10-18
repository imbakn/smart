#! /bin/bash

colorName()
{
    case $1 in
        0) echo -e "\x1b[1m"黑色"\x1b[0m";;
        1) echo -e "\x1b[1m"红色"\x1b[0m";;
        2) echo -e "\x1b[1m"绿色"\x1b[0m";;      
        3) echo -e "\x1b[1m"黄色"\x1b[0m";;
        4) echo -e "\x1b[1m"蓝色"\x1b[0m";;
        5) echo -e "\x1b[1m"洋红"\x1b[0m";;
        6) echo -e "\x1b[1m"天蓝"\x1b[0m";;
        7) echo -e "\x1b[1m"灰色"\x1b[0m";;
        8) echo -e "\x1b[1m"白色"\x1b[0m";;
        9) echo -e "\x1b[1m"白色"\x1b[0m";;
    esac
}

printColorHelp()
{
    echo "┌─────────┬─────────────────────────────────────────────────────────────────────────┐"
    echo -ne "\x1b[1m"
    echo "│ 属性    │ 加粗 1   正常 2   斜体 3   下划 4   闪烁 5   正常 6   反色 7   删除 9   │"
    echo -ne "\x1b[0m"
    echo "├─────────┼─────────────────────────────────────────────────────────────────────────┤"
    for i in {0..9}
    do
        echo -ne "│ $(colorName $i)  $i │ "
        echo -ne "\x1b[1;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[2;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[3;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[4;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[5;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[6;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[7;3$i""m颜色测试\x1b[0m "
        echo -ne "\x1b[9;3$i""m颜色测试\x1b[0m │"
        echo ""
    done
    echo "└─────────┴─────────────────────────────────────────────────────────────────────────┘"
    echo "eg:"
    echo 'echo -e "\x1b[1;33m颜色测试\x1b[0m"'
    echo -e "\x1b[1;33m颜色测试\x1b[0m"
    echo
    echo 'echo -e "\x1b[7;35m颜色测试\x1b[0m"'
    echo -e "\x1b[7;35m颜色测试\x1b[0m"
    echo
    echo 'echo -e "\x1b[5;34m颜色测试\x1b[0m"'
    echo -e "\x1b[5;34m颜色测试\x1b[0m"
    echo 'echo -e "\x1b[1;44;33m颜色测试\x1b[0m"'
    echo -e "\x1b[1;44;33m颜色测试\x1b[0m"
    echo 'use cmd like this: color.bash -b 2 -f 3 -m 1 测试信息'
}

printColorLine()
{
    while getopts 'b:f:m:' OPT; do
        case $OPT in
            b)
                BG_COLOR="$OPTARG";;
            f)
                FG_COLOR="$OPTARG";;
            m)
                FT_MODE="$OPTARG";;
            ?)
                echo "Usage: `basename $0` [options] content"
                echo "-b background color"
                echo "-f front color"
                echo "-m font mode"
        esac
    done
    shift $(($OPTIND - 1))
    
    if [ x"$BG_COLOR" != "x" ];then
        BG_COLOR="4"$BG_COLOR";"
    fi
    if [ x"$FG_COLOR" != "x" ];then
        FG_COLOR="3"$FG_COLOR";"
    fi
    if [ x"$FT_MODE" != "x" ];then
        FT_MODE=$FT_MODE";"
    fi
    
    #echo BG_COLOR $BG_COLOR
    #echo FG_COLOR $FG_COLOR
    #echo FT_MODE $FT_MODE
    
    WHOLE_STYLE=$FT_MODE$BG_COLOR$FG_COLOR
    WHOLE_STYLE=${WHOLE_STYLE%;}m
    echo "The command is:"
    echo "echo -e \"\x1b[$WHOLE_STYLE"$@"\x1b[0m\""
    echo "The effect is:"
    echo -ne "\x1b[$WHOLE_STYLE"
    echo -n "$@"
    echo -e "\x1b[0m"
}

if [ $# = 0 ];then
    printColorHelp
else
    printColorLine $@
fi













