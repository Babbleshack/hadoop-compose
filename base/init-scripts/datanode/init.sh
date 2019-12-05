#!/bin/bash
/etc/init.d/ssh start
while true
do
  tail -f $HADOOP_HOME/logs/*.log
  sleep 5
done
