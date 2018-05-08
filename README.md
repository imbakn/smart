# SMART 使用说明

标签（空格分隔）： linux android

---

smart 是一系列脚本和配置文件的集合,可以方便的进行android系统开发
下面是Android系统开发中经常会遇到的问题

> * 需要打开多个窗口, 如果窗口一多,就不知到那个是你想要的
> * 目录的跳转,涉及的目录很多,跳转很麻烦,经常要输入很长的路径
> * 工作空间初始化麻烦,每打开一个窗口都要跳转到相应的目录,然后执行source和launch
> * 感觉桌面太小,空间不够
> * 单独编译某个模块之后,不知道哪个文件修改了, 即使知道,也要写很长的命令去push或者install
> * 如何快速定位UI相关的BUG的位置


------

## 1. **快速跳转到工作空间并完成初始化**
编辑 `/home/imbak/.smart/personal/user.rc/myfunc.bash` 文件, 加入下面的内容
```
msm8917()
{
    cd  /home/ubuntu/kuspace/android/qcom/XBD_QCOM_MSM8917
    source ./build/envsetup.sh
    lunch zqp1168_p2lite-userdebug
    source $SMARTDIR/resource/init_android_env_var
}
```
这样在下次进入terminal之后就可以直接输入 `msm8917` 命令来完成工作空间的初始化.
下面的很多操作都依赖与这条命令

## 2. **多窗口分屏利器 tmux**
配置文件`/home/imbak/.smart/dotfiles/.tmux.conf`
需要大家去熟悉和使用,请参考我的配置不做过多解释

## 3. **tmxu 的管理器 tmuxinator**
tmuxinator的配置文件示例在`/home/imbak/.smart/personal/dotfiles/.tmuxinator`文件夹下面
例如 `/home/imbak/.smart/personal/dotfiles/.tmuxinator/msm8917.yml`
```
name: msm8917
root: ~/kuspace/android/qcom/msm8917
windows:
  - build:
      layout: main-vertical
      panes:
        - msm8917 && (aw) && reset
        - msm8917 && reset
        - msm8917 && reset
        - msm8917 && reset
  - editor: vim .
```
这样配置之后,下次打开terminal之后,可以直接执行 `tmuxinator msm8917` 就可以直接把terminal自动分成4格窗口,并完成每个窗口的初始化, aw 命令之后会讲到, msm8917 即 1 中加入的命令

## 4. **快速的目录跳转**

| 命令 | 用途 | 使用范围 |
| ------- | -------: | :------- |
| t       | 直接跳转到 android 项目根目录 | android项目初始化之后
| o       | 直接跳转到 android 项目out/.../zqp1168_p2lite目录 | android项目初始化之后
| j       | 弹出android的项目列表,支持模糊搜索  | android项目初始化, 并执行genfav.bash之后
|cd -     | 调到上一次的目录  | 通用
|cd1 ~ cd9| 向上跳转 N 级目录 | 通用

**j 命令说明:**
项目列表保存在根目录下`.myfavories`, 可以手动编辑, 加入自己的项目列表
也可以用`genfav.bash`自动生成,命令如下:
```
#! /bin/bash
if [ x"$T" != "x" ] ;then
    cd $T
    find frameworks/base/ frameworks/av/ frameworks/native/ packages/ system/ device/ hardware/ vendor/huaqin external/ -name Android.mk -exec dirname {} \; | grep -v tests > "$T"/.myfavories
    cd -
else
    echo "env T is not set, please check it"
fi

```

如果有需要可以自行修改.

## 5. **alias 设置, 缩短命令长度, 方便记忆**
下面贴一些我自己的配置
```
# 会使用 ubuntu 的默认方法打开文件
alias g='gnome-open'
alias c='cd'
alias v='vim'
alias b='bcompare'

##################### ADB ########################
# remount 可以在 android 没有启动的时候执行
alias rmt="adb wait-for-device && adb remount"
# 重启, 可以在正常模式和bootloader模式执行
alias rbt="adb reboot || fastboot reboot"
# 重启到bootloader模式
alias rbtb="adb reboot bootloader"
# 重启到recovery模式
alias rbtr="adb reboot recovery"
alias shl="adb wait-for-device && adb remount && adb shell"
alias log="adb logcat"
alias push="adb wait-for-device && adb remount &&  adb push"
alias pull="adb pull"
alias inst="adb install -r"
alias atop="watch adb shell top -m 20 -s cpu -n 1"

##################### AUTO PUSH ###################
alias aw="nohup android_inotify.py  >/dev/null 2>&1 &"
alias ae='[ -f "$T/.system.change" ] && vim "$T/.system.change"'
alias ap="adb wait-for-device && auto_push"
alias ai="adb wait-for-device && auto_install"

###################### REPO #######################
alias rp='repoupload'
alias rs='repo sync -j4'

###################### CHANGE DIR #################
alias t='[ -z "$T" ] || eval "cd $T"'
alias o='[ -z "$T" ] || eval "cd $T/out/target/product/$TARGET_PRODUCT"'
alias j='android_auto_jump'
alias mx='tmuxinator'

######################## TOOL #####################
# 查看top activity
alias ta="adb shell dumpsys activity activities | sed -En -e '/Running activities/,/Run #0/p'"
# 生成 kernel 启动时间耗时分析图
alias bgra="adb wait-for-device && adb shell dmesg | perl $T/kernel/msm-3.18/scripts/bootgraph.pl"
```

## 6. **快捷键 设置**
示例:
```
# \C- 表示Ctrl
# \e 表示Alt
# bind -x 把快捷键绑定到一条命令
# bind    把快捷键绑定到按键

bind -x '"\C-p": "spsk"'
# 在一条命令之前加上sudo,并执行
bind '"\es":"\C-asudo \C-e\C-m"'
```
可以自定义,文件路径:

    ~/.smart/common.rc/keybinds/xxx.bash

## 7. **修改terminal的提示路径**
android 目录都比较深,当显示全路径的时候会比较长,挤压命令的显示空间
**修改路径:**

    ~/.smart/common.rc/ps.bash


## 8. **快速安装android单编生成的文件**
| 命令 | 用途 |
| ------- | -------: |
| aw       | 开始监视 out/target/product/zqp1168_p2lite目录 |
| ae       | 用vim查看发生变化的文件 |
| ap       | 自动push所有文件  |
| ai       | 自动安装apk文件,push其他文件  |

 - aw 的监视目录依赖与

    cd  /home/ubuntu/kuspace/android/qcom/XBD_QCOM_MSM8917
    source ./build/envsetup.sh
    lunch zqp1168_p2lite-userdebug
 - aw 命令的实现依赖python3 ,使用 inotify 机制,所以不能监控新增的文件夹,适合全编之后启动,用来监控单编生成的文件
 - 一般 framework-res.apk 和systemui.apk 要 push ,其他的apk需要install
 - push之后要重启才能生效, install之后即刻生效

## 9. **fzf命令的使用**
**原生**
| 快捷键 | 用途 |
| ------- | -------: |
| Ctrl + r | 列出历史命令,选中后显示在命令行,回车之后执行 |
| Ctrl + t | 列出当前文件夹下所有文件和文件夹,选中后把路径显示在terminal中 |
| Alt + c | 列出当前文件夹下所有文件夹,选中后快速跳转  |

Alt + c 命令适合在使用 j 命令快速跳转到指定项目之后使用

**扩展**
| 命令 | 用途 |
| ------- | -------: |
| psf       | 用fzf列出所有的进程 |
| psk       | 用fzf列出所有的进程,选中杀死进程 |
| spsk       | 用fzf列出所有的进程,选中后 sudo 杀死进程  |
| apsk       | 用fzf列出android下所有的进程,选中杀死进程  |

**fzf的设计体现了linux的设计哲学**

## 10. **watch命令的使用**
watch用来周期执行一条命令,并显示结果
举一个例子:
android下执行top命令,结果很难看,并不会像在ubuntu下执行时那样刷新,那么可以做如下封装:

    alias atop="watch adb shell top -m 20 -s cpu -n 1"

## 11. **快速的执行jar包**
当下载的本地程序是以jar包的形式存在的话,每次都要这样执行

    java -jar  /path/of/jar/xxx.jar xxx

十分不方便.
这样使用会提高效率,把jar包放到`~/.smart/exec/jars`目录下面
然后执行`addalljar.sh`,这样比如jar包的名字是apktool_2.3.0.jar, 那么你就可以直接使用 apktool_2.3.0来执行.

## 12. **dotfiles管理**

 - 什么是dotfiles
   就是HOME目录下的以`.`开头的文件,
   文中使用的主要文件 `.vimrc .vimrc.bundle .tmux .tmux.conf .tmuxinator`
 - 文件存放在`~/.smart/dotfiles`文件夹,使用link到HOME目录

## 13. **adb shell 进去之后支持的命令太少**

adb shell 进入android 系统的终端之后支持的命令十分有限
vi ll 等都不支持
这里引入了 super_adb

    alias shl="adb wait-for-device && super_adb.py"

支持busybox 的各种命令, ll 可用
带彩色显示
user和userdebug都适用

## 14. **机器上连接wifi输入用户名密码太麻烦**

可以使用 awifi username password
使用的时候 焦点要定位到wifi登录页面的用户名输入框

## 15. **smart的结构以及扩展性**
```
├── common.rc
│   ├── alias       #存放alias
│   ├── keybinds    #存放快捷键绑定
│   ├── cdalias.bash
│   ├── fzf.bash
│   ├── ps.bash
│   ├── android_auto_jump.bash
│   └── tmuxinator.bash
├── docs
├── dotfiles        #dotfiles的存放路径
├── exec
│   ├── bash        #存放和保存自己的bash脚本
│   ├── jarlinks
│   ├── jars        #存放和保存自己的jar包
│   └── python      #存放和保存自己的python脚本
├── install.sh      #smart安装脚本
├── main.rc         #.bashrc中source的脚本
├── modules         #引入的第三方模块,以submodule方式存在
│   ├── fasd        #目录权重计算神器
│   ├── fzf         #模糊搜索神器
│   ├── spf13-vim   #vim的配置,管理方法值得学习
│   └── tmuxinator  #tmux管理器,更好的管理工作空间
├── others
│   ├── aptsource   #ubuntu的可以使用的源
│   ├── makecerts
│   ├── mysoftwarelist
│   └── spf13-vim.sh #spf13-vim 安装脚本
├── personal       #一个单独的git库,可以覆盖公共库中的设置
│   ├── dotfiles
│   └── user.rc
├── README.md
└── resource
    └── init_android_env_var
```
