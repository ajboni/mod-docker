#!/bin/bash

# Need to add the audio group, the current user groups, add limits for RT kernel and map /dev/shm so we can connect to JACK
docker run \
-it \
--rm \
-e USER_NAME=$(id -un) \
-e USER_ID=$(id -u) \
-e GROUP_ID=$(id -g) \
-e GROUP_NAME=$(id -gn) \
--ulimit rtprio=99 \
--cap-add=sys_nice \
--ulimit memlock=819200000:819200000 \
test:latest

# --detach \