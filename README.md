# Hadoop Docker Image

teamsprint/hadoop:2.7.3

[![DockerPulls](https://img.shields.io/docker/pulls/teamsprint/docker-hadoop.svg)](https://registry.hub.docker.com/u/teamsprint/docker-hadoop/)
[![DockerStars](https://img.shields.io/docker/stars/teamsprint/docker-hadoop.svg)](https://registry.hub.docker.com/u/teamsprint/docker-hadoop/)

# Based on (in a row)

teamsprint/centos:7<br/>
teamsprint/jdk:8<br/>

# Build the image

run build.sh

# Start a container

run run.sh

The container name is "hadoop". If you don't want, just edit the scripts.

# Attach a container

run attach.sh

# Destroy containers

run destroy.sh

# IMPORTANT: After attach you might to want to to:
./hadoop-start.sh (HDFS & Yarn)<br/>
./hadoop-test.sh (Optional)<br/>

