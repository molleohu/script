
# CAT + EOF命令分析

在脚本文件处理中，会有这样的使用场景:根据脚本运行中的动态状态生产不同的内容到文件中。<br>
举例:<br>
在configure配置项目是，会进行头文件的检查或者函数的检查，其原理就是编译一个简易的源文件，如果通过表示支持，不通过则不支持。<br>
而这个简易的源文件则是通过cat和EOF来生成的。<br>
其基本写法:
```Bash
cat << EOF > 1.c
....
....
EOF
```
上面的写法通常会被认为是固定的写法，其实进行简单分析，其就是两部分组成的:<br>
<b>1. Bash Here Documents语法生成一个匿名文件。(我的理解是只知道文件内容，但是没有文件名)</b><br>
    Here Documents语法为:<br>
    <<[-]word<br>
    ...<br>
    ...<br>
    word<br>
`说明:这里的word不一定是EOF。`<br>
<b>2. cat 把匿名文件的内容输出到其他文件中。</b><br>

<b>3. 对于第1点描述的匿名文件，我的理解是只指导文件内容，不知道文件名。所以对内容操作的命令都可以与Here Docuemnts结合。</b><br>
例如:<br>
* 与cat类似的less
```Bash
less <<EOF
...
EOF
```
* 统计内容的行数
```Bash
wc -l <<EOF
...
EOF
```
* md5sum校验多行数据
```Bash
md5sum <<EOF
...
EOF
```

<b>4. 举例</b><br>
* 根据变量名写入
```Bash
Name=Leo.hu
cat << EOF > 1.txt
${Name}
EOF
cat 1.txt
```
* 统计行数,word不使用EOF,使用HHH
```Bash
wc -l << HHH
b
a
s
h
HHH
```
* md5sum校验
```Bash
md5sum 1.txt
md5sum <<EOF
${Name}
EOF
```
