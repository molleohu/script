# 脚本介绍
--2018.10.15 <br>
该目录中主要存放一些工作或者学习中，使用过的脚本，包括并不限于Shell, Python, Bat等。<br>
后续会陆续整理并上传。<br>
<br>
## 例子 <br>
### 1. 通过echo输入16进制数到文件中 <br>
有以下两个方式都能够实现，不过我最常采用的是`echo -en`方式。<br>
```Bash
echo -n $'\xA5' > .factory_status
echo -en '\xA5' > .factory_status
```

### 2. 去除文件中的0D(回车符)<br>
Window系统对文本的换行有2个字符:0D(回车) 0A(换行) ; Linux系统对文本的换行只有一个字符:0A(换行)。在Linux系统下面写代码时，通常我会先转换一下，不然在打开文件时会出现^M符号。<br>
`dos2unix`文件内容为:<br>
```Bash
#!/bin/bash

#
#
#去除文件中的CR 0x0D 换行符。

echo "$1 2 unix ..."
//g' $1's/

```

关于回车换行的前世今生可以阅读该篇文章:[<知无涯之回车换行的故事>](http://feihu.me/blog/2014/end-of-line/ "悬停显示")<br>

### 3. 分析PS1字串<br>
```Bash
PS1="\\[\\e]0;\\w\\a\\]\\n\\[\\e[32m\\]\\u@\\h \\[\\e[33m\\]\\w\\[\\e[0m\\]\\n\\\$ "
```
PS1可以简化分为以下几个部分:<br>
```Bash
  PS1a = \e]0;\w\a # 终端的标题栏修改为当前路径
  PS1b = \e[32m		#绿色字符
  PS1c = \e[33m		#棕色字符
  PS1d = \e[[0m		#Reset字符颜色
  PS1 => {PS1a}换行{PS1b}\u@\h ${PS1c}\w${PS1d}换行\$
```


