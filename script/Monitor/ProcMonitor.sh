#!/bin/bash

PARA_WATCHER_FILE='/data/nginxhtml/cgi_bin_security/nohup.out'
PRAR_PROC_NAME='spawn-fcgi-watcher'
PRAR_PID_FILE='/data/nginxhtml/cgi_bin_security/server.pid'
PARA_HOST_ID=""
PARA_SERVER_ID="cgi_bin_security"

CMD_GREP='/bin/grep'
CMD_AWK='/usr/bin/awk'
CMD_SED='/bin/sed'

cd `dirname $0`
SUB_PID=`ps -eo pid,args | "$CMD_GREP" -v grep | "$CMD_GREP" $PRAR_PROC_NAME | "$CMD_GREP" $PRAR_PID_FILE | "$CMD_AWK" '{print $1}'`
if [ -z "$SUB_PID" ];then
	echo server not running.
	exit 1
fi
tail --lines=0 --max-unchanged-stats=5 --pid="$SUB_PID" --sleep-interval=60 -F "$PARA_WATCHER_FILE" | \
while read SUB_LINE;
do 
	SUB_INFO=`echo -n $SUB_LINE | "$CMD_GREP" 'unusually'`
	if [ -n "$SUB_INFO" ];then
		./sendmail.sh 3 "_安全中心-CORE-日志" "ERROR : [`date +%Y-%m-%d_%H:%M:%S`] : ($PARA_HOST_ID:$PARA_SERVER_ID)$SUB_LINE"
	fi
#	SUB_INFO=`echo -n $SUB_LINE | "$CMD_GREP" 'child spawned successfully' | $CMD_AWK -FPID: '{print $2}' | bc 2>/dev/null`
#	if [ -n "$SUB_INFO" ] && [ "$SUB_INFO" -gt 0 ];then
#		./ErrMonitor.sh "$SUB_INFO" &
#	fi
done

