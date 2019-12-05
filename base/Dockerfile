FROM ubuntu:bionic

MAINTAINER Babbleshack <dcrl94@gmail.com> Version: 0.2

ARG HADOOP_VERSION_ARG=3.2.1
ARG CLUSTER_NAME_ARG=hadoop-cluster

ENV HADOOP_VERSION=$HADOOP_VERSION_ENV
ENV CLUSTER_NAME=$CLUSTER_NAME_ENV

ENV HADOOP_HOME=/opt/hadoop

#HELPER SCRIPTS
ENV INIT_SCRIPT_DIR=/opt/init_container.d

#HADOOP DIRS
ENV HADOOP_DATA_NODE_DATA=${HADOOP_HOME}/hdfs/datanode
ENV HADOOP_NAME_NODE_DATA=${HADOOP_HOME}/hdfs/namenode
ENV HADOOP_TEMPDIR=${HADOOP_HOME}/hadooptmpdata

#SETUP PATH
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

#CONFIGURE IMAGE
RUN apt update && apt install -y bash vim openjdk-8-jdk-headless openssh-server openssh-client curl libcgroup1 python3 python3-pip

RUN pip3 install yarn_api_client 

# passwordless ssh, update to use pregenerated keys.
RUN rm -rf /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key 
RUN rm -rf /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key 
RUN rm -rf /root/.ssh/id_rsa && ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa 
RUN cp -f /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

#INSTALL HADOOP
#http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz
#http://mirrors.ukfast.co.uk/sites/ftp.apache.org/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz
#RUN curl -Lv http://mirrors.ukfast.co.uk/sites/ftp.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz \
RUN curl https://mirrors.ukfast.co.uk/sites/ftp.apache.org/hadoop/common/stable/hadoop-${HADOOP_VERSION_ARG}.tar.gz -o /tmp/hadoop.tar.gz \
        && tar xzf /tmp/hadoop.tar.gz -C /tmp/ \
        && mv -v /tmp/hadoop-${HADOOP_VERSION_ARG} ${HADOOP_HOME} \
        && mkdir -pv ${INIT_SCRIPT_DIR} \
        && mkdir -pv /opt/yarn-conf/hadoop

COPY ./common/hadoop/etc/* ${HADOOP_HOME}/etc/hadoop/
COPY ./common/ssh/ssh_config /etc/ssh/
#copy ./files/yarn-local.yarn-site.xml /opt/yarn-conf/hadoop/yarn-site.xml

#Configure hadoop data dirs
RUN mkdir -pv ${HADOOP_DATA_NODE_DATA} \
        && mkdir -pv ${HADOOP_NAME_NODE_DATA} \
        && mkdir -pv ${HADOOP_TEMPDIR} \
        && mkdir -pv ${INIT_SCRIPT_DIR} 
        #&& mkdir -pv /yarn-conf \
        #&& cp -rfv /opt/hadoop/etc/hadoop /yarn-conf \
        #&& cp -rfv /opt/yarn-conf/* /yarn-conf

#COPY INIT SCRIPTS
COPY ./init-scripts ${INIT_SCRIPT_DIR}/
COPY ./common/workers /opt/workers


##HADOOP ENVRIONMENT VARS
# TODO: REMOVE THESE AND PLACE THEM IN `.env`
ENV MAPRED_EXAMPLES=/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_INSTALL=/opt/hadoop
ENV HADOOP_MAPRED_HOME=/opt/hadoop
ENV HADOOP_COMMON_HOME=/opt/hadoop
ENV HADOOP_HDFS_HOME=/opt/hadoop
ENV YARN_HOME=/opt/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=/opt/hadoop/lib/native
ENV HADOOP_OPTS="-Djava.library.path=/opt/hadoop/lib/native"
ENV HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop 
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

#HADOOP USERS
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"
ENV YARN_EXAMPLES=/opt/hadoop/share/hadoop/mapreduce

