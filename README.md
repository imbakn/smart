## SMART

-----

**SMART** 是我整理的一系列脚本和工具的集合，用于方便Android系统开发，它从以下几个方面对bash进行了增强。

- [更方便的获取帮助信息](#更方便的获取帮助信息)
- [快速的初始化android工作环境](#快速的初始化android工作环境)
- [快速的目录跳转](#快速的目录跳转)
- [快速的文件和文件内容搜索](#快速的文件和文件内容搜索)
- [Android模块单编之后快速的push和install](#android模块单编之后快速的push和install)
- [快速的使用fastboot进行刷机](#快速的使用fastboot进行刷机)
- [集成了busybox的shell](#集成了busybox的shell)
- [增强了日志查看工具](#增强了日志查看工具)
- [提交代码的命令的封装](#提交代码的命令的封装)
- [集成了常用逆向工具](#集成了常用逆向工具)
- [其他有用信息](#其他有用信息)


### 安装

- **一行命令进行安装**

`curl https://raw.githubusercontent.com/imbakn/smart/master/install.sh -L -o - | sh`

- **常规安装**

```bash
git clone https://github.com/imbakn/smart ~/.smart
cd ~/.smart
./install.sh
```



### 更方便的获取帮助信息
**`h`命令,`cheat_help`的简写**
直接执行`h`,会弹出支持的所有命令列表，支持模糊搜索，回车或者鼠标确定  
执行`h COMMAND`，展示COMMAND命令的帮助文件，彩色显示，示例丰富，支持命令补全  

### 快速的初始化android工作环境
**`cap`命令, `create_android_project`的简写**  
使用方法为:`create_android_project PRODUCT_NAME PRODUCT_VARIANT`，必须运行在Android项目根目录  
**例如:** cap project_watch zwd503-userdebug  
cap 会在Android跟目录下生成 `.myfavories` 文件，用来进行 `android_auto_jump` 跳转  

**`sap`命令，`start_android_project`的简写**  
使用方法为:`start_android_project PRODUCT_NAME`, 可以运行在任何地方，每新开一个终端都需要重新运行此命令  
**例如:** sap project_watch  
sap 会执行如下操作:  
- 跳转到Android项目根目录
- `chmod 666 out/host/linux-x86/bin/adb` 防止和系统的adb冲突
- 执行`source build/envsetup.sh`
- 执行`lunch zwd503-userdebug`
- export 环境变量 TARGET_BUILD_VARIANT TARGET_PRODUCT T
- 包含`godir`命令
- 启动`aw`,进行android生成的system目录下的文件监控，以便进行自动的install和push

**cap和sap是SMART工具集的核心命令，很多工具的使用都依赖与正确的Android工作环境初始化**


### 快速的目录跳转
**`j`命令,`android_auto_jump`的简写**  
Android整个工程由很多小的项目组成，我们认为包含`Android.mk`的目录即为一个项目(编译单元)  
我们把这些项目列表保存在根目录下`.myfavories`中(`cap`时自动生成), 也可以手动编辑, 加入自己的项目列表  
也可以使用`genfav.bash THE_DIR_YOU_WANT_TO_ADD`,会把`THE_DIR_YOU_WANT_TO_ADD`下面所有包含`Android.mk`的目录添加进去  
直接执行`j`,会弹出所有项目的列表，支持模糊搜索，回车或者鼠标确定后，跳转到相应目录  
执行`j SOMETHING_TO_SEARCH`,会弹出所有项目的列表，`SOMETHING_TO_SEARCH`直接出现在搜索栏，支持模糊搜索，回车或者鼠标确定后，跳转到相应目录  
当只有一个项目匹配的时候直接跳到这个目录  

**`a`命令，`goto_mk_dir`的简写**  
直接执行`a`，会跳转到包含`Android.mk`的父目录  
**例如:** 当前目录`frameworks/base/core/res/res`  
执行`a`, 跳转到`frameworks/base/core/res`  
再执行`a`，跳转到`frameworks/base`  
再执行`a`，不跳转  

**`o`命令，**  
直接执行`o`，跳转到输出目录(`cd $T/out/target/product/$TARGET_PRODUCT"`)  

**`t`命令，**  
直接执行`t`，跳转到Android根目录  

**`godir`命令**  
执行`godir THE_FILE_WANT_TO_SEARCH`，跳转到包含`THE_FILE_WANT_TO_SEARCH`文件的目录  
如果有不止一个文件，会弹出一个列表，支持模糊搜索  

**`cdN`命令,回退N级目录(N >= 1 and N<=9)**  
**例如:** cd5 回退5级目录，等价与`cd ../../../../../`  

### 快速的文件和文件内容搜索
使用`ag`命令进行搜索，比`grep`和`ack`速度更快，非常适合Android源码量巨大的情况  
如果想深入学习请自行参考`ag`的帮助文件，这里仅做简单介绍  
命令使用简单，支持指定文件类型搜索，可以过滤不想搜索的文件，比如Android有很多其他语言的资源文件，可以过滤掉除了英文和中文意外的  
用`tag`命令封装`ag`，搜索的每个结果会添加一个编号N，直接执行`eN`就会直接用vim打开文件，并跳转到相应的位置  

### Android模块单编之后快速的push和install
`sap`命令会自动启动`aw`  
`aw`会对`$T/out/target/product/$TARGET_PRODUCT/system`下的文件进行监控，  
当文件有变化的时候就会把变化的文件记录到`$T/.system.change`里  
然后才可以执行下面的命令:  
- `ae`:编辑`$T/.system.change`文件  
- `ap`:把`$T/.system.change`中记录的文件都push到andorid机器中  
- `ai`:把`$T/.system.change`中记录的非apk文件都push到andorid机器中，apk文件进行安装  
**注意，SystemUi.apk 和 frameworks-res.apk 应该push到系统下**  
**push文件之后应该重启系统，如果仅仅涉及apk的安装，不需要重启系统**   

### 快速的使用fastboot进行刷机
**可以使用`fast brs`进行快速的fastboot，封装了如下步骤:**
- 进入fastboot模式
- fastboot boot，recovery，system
- 重启系统

可以选择刷 boot，recovery，system  
**例如:**  
`fast b`  会刷 boot  
`fast bs` 会刷 boot 和 system  


### 集成了busybox的shell
adb shell 进入android 系统的终端之后支持的命令十分有限  
vi ll 等都不支持  
这里引入了 super_adb  
`alias shl="adb wait-for-device && super_adb.py"`  
支持busybox 的各种命令, ll 可用，带彩色显示，user和userdebug都适用  


### 增强了日志查看工具
使用`lg`命令查看log  
支持模糊搜索，可以快速定位问题  
如果选中普通的条目会使用VIM打开log并跳转到指定行数  
如果选中的条目包含Java崩溃的信息，会直接跳转到出错的文件的位置(要已经使用sap初始化工作空间)  

### 提交代码的命令的封装
使用`rpush`命令，封装了如下过程  
- 使用`fpp`选择需要提交的文件
- 打开VIM，填写commit msg 信息
- repo upload


### 集成了常用逆向工具
- apktool
- jdgui
- baksmali
- smali
- d2j-dex2jar.sh d2j-apk-sign.sh 等

### 其他有用信息

- [一些非常好用的脚本介绍]()
- [如何学习VIM](./docs/how_to_learn_vim.md)
- [Android调试技巧]()
- [命令行神器介绍]()
- [Android学习资源]()
- [那些值得follow的GitHub]()
