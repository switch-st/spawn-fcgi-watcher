#!/bin/bash

cd /data/nginxhtml/cgi_bin_security/script
source /usr/local/app/.bashrc
PID=`seep.sh watcher | grep -w /data/nginxhtml/cgi_bin_security/mainFunc | awk '{print $2}'`
if [ -n "$PID" ]; then
	kill $PID
fi
while true
do
	sleep 1;
	NUM=`./see_server.sh | wc -l`
	if [ "$NUM" == "1" ];then
		break
	fi
	echo "num: $NUM, waiting..."
done
exit 0
