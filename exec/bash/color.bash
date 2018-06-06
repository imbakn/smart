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


echo "┌─────────┬─────────────────────────────────────────────────────────────────────────┐"
echo -ne "\x1b[1m"
echo "│ 属性    │ 加粗 1   正常 2   斜体 3   下划 4   闪烁 5   正常 6   反色 7   删除 9   │"
echo -ne "\x1b[0m"
echo "├─────────┼─────────────────────────────────────────────────────────────────────────┤"
for i in {0..9}
do
    echo -ne "│ $(colorName $i) 3$i │ "
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


