#!/bin/bash

PROC_NUM="500"

source /usr/local/app/.bashrc
ulimit -c unlimited
cd /data/nginxhtml/cgi_bin_security
nohup spawn-fcgi-watcher -d /data/nginxhtml/cgi_bin_security -a 127.0.0.1 -p 9000 -F "$PROC_NUM" -P /data/nginxhtml/cgi_bin_security/server.pid /data/nginxhtml/cgi_bin_security/mainFunc >> nohup.out 2>&1 &

cd /data/nginxhtml/cgi_bin_security/script
let PROC_NUM=$PROC_NUM+2
while true
do
	sleep 1
	NUM=`./see_server.sh | wc -l`
	if [ "$NUM" == "$PROC_NUM" ];then
		break
	else
		echo "num: $NUM, waiting..."
	fi
done

cd /data/nginxhtml/cgi_bin_security/script
Monitor/ProcMonitor.sh >> Monitor/pm.log 2>&1 &
#Monitor/ErrMonitor.sh >> Monitor/em.log 2>&1 &
