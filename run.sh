#!/bin/bash
export USER_NAME=$(id -un)
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export GROUP_NAME=$(id -gn)

docker-compose up  --build mod-setup
docker-compose up --build mod-host mod-ui
# docker-compose up  --build mod-ui