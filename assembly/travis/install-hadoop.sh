#!/bin/bash

set -ev

TRAVIS_DIR=`dirname $0`
HADOOP_DOWNLOAD_ADDRESS="http://archive.apache.org/dist/hadoop/core"
HADOOP_PACKAGE="hadoop-2.8.0"
HADOOP_TAR="${HADOOP_PACKAGE}.tar.gz"

# install ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 744 ~/.ssh/authorized_keys

# download hadoop
if [[ ! -f $HOME/downloads/${HADOOP_TAR} ]]; then
  wget -q -O $HOME/downloads/${HADOOP_TAR} ${HADOOP_DOWNLOAD_ADDRESS}/${HADOOP_PACKAGE}/${HADOOP_TAR}
fi

# decompress hadoop
cp $HOME/downloads/${HADOOP_TAR} ${HADOOP_TAR} && tar xzf ${HADOOP_TAR}

# config hadoop
cp -f ${TRAVIS_DIR}/core-site.xml ${HADOOP_PACKAGE}/etc/hadoop/
cp -f ${TRAVIS_DIR}/hdfs-site.xml ${HADOOP_PACKAGE}/etc/hadoop/

# format hdfs
${HADOOP_PACKAGE}/bin/hadoop namenode -format

# start hadoop service
${HADOOP_PACKAGE}/sbin/start-dfs.sh

jps
