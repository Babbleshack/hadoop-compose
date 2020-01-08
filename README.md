# HADOOP Docker-Compose
Hadoop Yarn/HDFS inside a docker-compose manifest.


## Commands:
- Start Containers: `docker-compose up -d`
- Container Status: `docker-compose ps`
- Stop and Delete Containers: `docker-compose rm -sf`
- SSH into resourcemanager container: `docker-compose exec resourcemanager /bin/bash`

## Notes:
Services are dependant

## HADOOP Paths:
- Hadoop Home: `/opt/hadoop`
- Distrubted Hadoop Home: `/yarn-conf/hadoop`

### Run Opportunistic Run With:
`yarn --config /yarn-conf/hadoop/ jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi -Dmapreduce.job.num-opportunistic-maps-percent="100" 6 1`

### Run Guaranteed Run With:
`yarn --config /yarn-conf/hadoop/ jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar pi -Dmapreduce.job.num-opportunistic-maps-percent="50" 6 1`


# TODO:
- [ ] volumes for hdfs
- [ ] [repliceated services?] (https://docs.docker.com/compose/compose-file/#replicas)
