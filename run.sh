#!/bin/bash
export USER_NAME=$(id -un)
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export GROUP_NAME=$(id -gn)

docker build  --rm -f "mod-ui/Dockerfile" -t mod-ui "mod-ui"
docker-compose up  --no-build mod-ui
