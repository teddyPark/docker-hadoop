#!/bin/bash

set -x

hdfs dfs -mkdir -p /user/hadoop/input
hdfs dfs -put $HADOOP_PREFIX/LICENSE.txt /user/hadoop/input
hadoop jar $HADOOP_PREFIX/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /user/hadoop/input /user/hadoop/output

