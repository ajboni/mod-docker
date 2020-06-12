# mod-docker

This project aims to provide 2 docker containers in order to use mod-host and mod-ui painlessly.

# REQUIREMENTS
You need to be running JACK.

# GOALS
* We should be able to isolate the lv2 plugin folder from host and map the github repo to the container. 
* We should be able to pass via env variable
* We should provide easy mechanism to upgrade plugin repo and containers.
* Running both containers should be the only thing need it to run.

# GOTCHAS
* Extend mod-ui to accept ENV VARIABLE to correctly name JACK output.
* Wait to mod-host before running mod-ui
* build source from github.
* Research about jack-client permissions

