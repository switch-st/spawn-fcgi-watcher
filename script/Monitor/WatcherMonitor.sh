#!/bin/bash

PARA_WATCHER_FILE='/data/nginxhtml/cgi_bin_security/nohup.out'
PRAR_PROC_NAME='spawn-fcgi-watcher'
PRAR_PID_FILE='/data/nginxhtml/cgi_bin_security/server.pid'
PARA_FLAG_FILE='/data/nginxhtml/cgi_bin_security/script/Monitor/watcher.tmp'
PARA_HOST_ID=""
PARA_SERVER_ID="cgi_bin_security"

CMD_GREP='/bin/grep'
CMD_AWK='/usr/bin/awk'
CMD_SED='/bin/sed'

source /usr/local/app/.bashrc
cd `dirname $0`
if [ -f "$PARA_FLAG_FILE" ];then
	exit
fi
SUB_PID=`ps -eo pid,args | "$CMD_GREP" -v grep | "$CMD_GREP" $PRAR_PROC_NAME | "$CMD_GREP" $PRAR_PID_FILE | "$CMD_AWK" '{print $1}'`
if [ -z "$SUB_PID" ];then
	../start_server.sh
	./sendmail.sh 3 "_安全中心-监控进程-日志" "ERROR : [`date +%Y-%m-%d_%H:%M:%S`] : ($PARA_HOST_ID:$PARA_SERVER_ID)watcher process down, restart server."
fi

