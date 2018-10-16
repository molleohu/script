实现在host机监控target设备(linux系统)的内存情况。

依赖:
1. scp 		远程拷贝文件。
1. expect 	自动输入密码。
2. gnuplot 	绘制内存数据的曲线。

说明:
1. target_memory.sh 在target设备中运行，生成的文件可以放在nfs mount目录中。
注意:如果不需要实时监控可以拷机一段时间后，再把输出文件拷贝出来。
./target_memory.sh mem_output.txt

2. remote_copy.sh 从target设备中拷贝第一步中生成的文件拷贝到本地。(可以通过其他方式)

3. host_draw_memory.sh 根据内存数据文件来绘制。绘制的曲线图片保存为png格式文件。

4. 用系统自带的工具打开png图片。后续如果文件内容更新，工具显示也会自动刷新，从而实现实时监控。
