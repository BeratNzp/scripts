#!/bin/bash
PUSHGATEWAY_SERVER=http://PUSHGATEWAYSERVERIP:9091
NODE_NAME=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
JOB_NAME="sample"
sleep 4
for ((i=1; i<=12; i++)) # 12*5=60 (If you add this script to crontab for every minute, metrics will send to every 5 seconds)
do
	DATE=$(date +"%T")
	curl -s localhost:9100/metrics | curl --data-binary @- $PUSHGATEWAY_SERVER/metrics/job/$JOB_NAME/instance/$NODE_NAME
	sleep 5
done
