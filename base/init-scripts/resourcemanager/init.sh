#!/bin/bash
/etc/init.d/ssh start
cp -fv opt/workers/yarn_workers $HADOOP_HOME/etc/hadoop/workers
rm -rf $HADOOP_HOME/hadooptmpdata/*
$HADOOP_HOME/bin/yarn --daemon start resourcemanager
$HADOOP_HOME/bin/mapred --daemon start historyserver
$HADOOP_HOME/bin/yarn --daemon start timelineserver
while true
do
	tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
