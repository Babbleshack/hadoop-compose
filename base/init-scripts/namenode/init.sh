#!/bin/bash
/etc/init.d/ssh start
cp -fv opt/workers/hdfs_workers $HADOOP_HOME/etc/hadoop/workers
$HADOOP_HOME/bin/hdfs namenode -format 
$HADOOP_HOME/sbin/start-dfs.sh &
while true
do
  tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
