# Bash PS1字串的分析

## 参考文档<br>
* Ref1: [https://unix.stackexchange.com/questions/306716/meaning-of-e0-in-ps1-in-bashrc?rq=1](https://unix.stackexchange.com/questions/306716/meaning-of-e0-in-ps1-in-bashrc?rq=1) <br>
* Ref2: [https://www.x.org/docs/xterm/ctlseqs.pdf](https://www.x.org/docs/xterm/ctlseqs.pdf) <br>
* Ref3: man bash page <br>

## 分析
无意中在cygwin中看到PS1的定义。其定义如下:<br>
```Bash
declare -x PS1="\\[\\e]0;\\w\\a\\]\\n\\[\\e[32m\\]\\u@\\h \\[\\e[33m\\]\\w\\[\\e[0m\\]\\n\\\$ "
```
在看到这个定义之前，自认为还是能够看懂shell的一些脚本或者内容的。但是看到该字串确没有反应过来，所以决定好好分析一下。<br>

### 1. 对上述PS1进行简化，得到如下PS1.<br>
```Bash
PS1=\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ 
```
### 2. 为了显示交互处理的信息，Bash定义了一些转义字串。--from man Bash page. <br>
```Bash
\a		响铃
\e		Escape字符
\h		主机名
\u		当前用于的名字
\w		当前工作目录
\$		如果是root用户，显示'#',否则显示'$'
\[	  开始一系列非打印字符，可用于将终端控制序列嵌入到提示中
\]		结束一系列非打印字符
```
### 3. PS1可以简化分为以下几个部分:<br>
```Bash
PS1a = \e]0;\w\a #这部分不太明白，后续即使请见第5点
PS1b = \e[32m		#绿色字符
PS1c = \e[33m		#棕色字符
PS1d = \e[[0m		#Reset字符颜色
PS1 => {PS1a}换行{PS1b}\u@\h ${PS1c}\w${PS1d}换行\$
```
### 4. 实际终端提示符信息如下: <br>
```Bash
SDT12273@SDT12273-NB1 /etc
$
其中 SDT12273@SDT12273-NB1 是绿色字符。 /etc 是棕色字符。
```
### 5. 上面第3点提到的PS1a,当时有点不明白表示的什么意思。经过Google，终于知道什么意思啦。<br>
语法在Ref2中有描述:<br>
```Bash
ESC]Ps;PtBEL --->ESC]Ps;Pt\a
a. Ps=0 ==> Change Icon Name and Window Title to Pt.
b. Ps=1 ==> Change Icon Name to Pt.
c. Ps=2 ==> Change Window Title to Pt.
d. Ps=3 ==> Change Log File to Pt.(normaly disable by compile-time option)
```
所以根据语法规则，PS1a=\e]0;\w\a 表示的意思就是终端的标题栏修改为当前路径。<br>
