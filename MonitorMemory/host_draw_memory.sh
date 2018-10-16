#!/bin/bash

echo "===Monitor STB Memory==="

debug_echo() {
	local what=$*
	echo "$(date +%H:%M:%S) ${what}"
}

while true
do

:<<dont_need_remote_copy
	if [ -f output.txt ];then
		rm -rf output.txt	
	fi
	./remote_copy.sh
	if [ $? != 0 ];then
		debug_echo "copy output error!!"
		sleep 8
		continue	
	fi
dont_need_remote_copy

	if [ ! -f output.txt ];then
		debug_echo "output.txt is not exist!!"
		sleep 8
		continue;	
	fi

	gnuplot -c draw_plot.conf
	if [ $? != 0 ];then
		debug_echo "gunplot error!!"
	fi
	sleep 10
done

exit 0
