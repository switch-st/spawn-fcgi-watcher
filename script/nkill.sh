#!/bin/bash

if [ -z "$1" ];then
	exit 1
fi

echo "进程列表："
ps aux | head -1
ps aux | /bin/grep -v grep | /bin/grep -v nkill.sh | /bin/grep --color=auto $1
declare -a result=(`ps aux | /bin/grep -v grep | /bin/grep -v nkill.sh | /bin/grep --color=auto $1 | awk '{print $2}'`)
procNum=${#result[@]}
echo

echo "请输入要杀进程的序号[all]:"
declare -a choiceArr
read choice
if [ -z "$choice" ];then
	choice="all"
fi
choiceArr=($choice)

if [ "$choice" == "all" ];then
	for ((i=0; i<$procNum; ++i))
	do
		kill ${result[$i]}
	done
else
	choiceNum=${#choiceArr[@]}
	for ((i=0; i<$choiceNum; ++i))
	do
		if [ "${choiceArr[$i]}" -le "$procNum" ];then
			kill ${result[`expr ${choiceArr[$i]} - 1`]}
		fi
	done
fi

echo
echo "查看结果:"
ps aux | head -1
ps aux | /bin/grep -v grep | /bin/grep -v nkill.sh | /bin/grep --color=auto $1

