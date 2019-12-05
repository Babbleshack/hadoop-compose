#!/bin/bash
rm -rf $HADOOP_HOME/hadooptmpdata/*
/etc/init.d/ssh start
#update scheduler address
sed -i 's/0.0.0.0:8030/0.0.0.0:8049/' $HADOOP_HOME/etc/hadoop/yarn-site.xml
$HADOOP_HOME/bin/yarn nodemanager
while true
do
  tail -f $HADOOP_HOME/logs/*.log 
  sleep 5
done
