#!/bin/bash

# Run the container
# Need to add the audio group, the current user groups, add limits for RT kernel and map /dev/shm so we can connect to JACK

docker run --rm \
--group-add audio \
--group-add $(id -g) \
-it \
--volume=/dev/shm:/dev/shm:rw \
--user=$(id -u):$(id -g) \
--ulimit rtprio=99 \
--cap-add=sys_nice \
--ulimit memlock=819200000:819200000 \
mod-host:latest