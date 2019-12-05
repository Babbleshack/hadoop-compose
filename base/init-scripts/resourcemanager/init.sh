#!/bin/bash
/etc/init.d/ssh start
cp -fv opt/workers/yarn_workers $HADOOP_HOME/etc/hadoop/workers
rm -rf $HADOOP_HOME/hadooptmpdata/*
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver &
while true
do
	tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
