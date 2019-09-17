#!/bin/bash

docker run -d -it --name h1 -p 18088:8088 -p 18042:8042 --privileged teamsprint/hadoop:2.7.3 /usr/sbin/init
docker exec -it h1 /bin/bash

