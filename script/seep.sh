#!/bin/bash

if [ -z "$1" ];then
	echo "Usage : $0 [PARA] PATTERN"
	exit 1;
fi

para=($*)
for ((i=1; i<${#para[@]}; ++i))
do
	psPara+=" ${para[`expr $i - 1`]}"
done

if [ -z "$psPara" ];then
	psPara="aux"
fi

ps $psPara | head -1
ps $psPara | /bin/grep -v seep.sh | /bin/grep -v grep | /bin/grep --color=auto ${para[`expr $i - 1`]}

