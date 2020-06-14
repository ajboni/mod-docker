#!/bin/bash

# Run the container

# For some reason, if I don't create it before hand on the host, docker will set the owner to root.
mkdir ~/.mod-docker

# Need to add the audio group, the current user groups, add limits for RT kernel and map /dev/shm so we can connect to JACK
docker run \
-it \
--rm \
--group-add audio \
--group-add $(id -g) \
--volume=/dev/shm:/dev/shm:rw \
--volume=/etc/passwd:/etc/passwd:ro \
--volume=/etc/group:/etc/group:ro \
--user=$(id -u):$(id -g) \
--ulimit rtprio=99 \
--cap-add=sys_nice \
--ulimit memlock=819200000:819200000 \
-v ~/.mod-docker:$HOME \
-e USER=$(whoami) \
-p 8888:8888 \
mod-host:latest

# --detach \