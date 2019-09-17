#!/bin/bash

CONTAINER_NAME=hadoop

docker run -d -it --name $CONTAINER_NAME -p 18088:8088 -p 18042:8042 --privileged teamsprint/hadoop:2.7.3 /usr/sbin/init
docker exec -it $CONTAINER_NAME /bin/bash

