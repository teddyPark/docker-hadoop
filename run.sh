#!/bin/bash

IMAGE_NAME=teamsprint/hadoop:2.7.3
CONTAINER_NAME=hadoop

# This booting pattern is for consistency among the images of teamsprint.
# # docker-mysql has to be run in this way. (Security issue)
sudo docker run -d -it --name $CONTAINER_NAME -p 18088:8088 -p 18042:8042 --privileged $IMAGE_NAME /usr/sbin/init
sudo docker exec -it $CONTAINER_NAME /bin/bash

