# mod-docker

MOD-DOCKER is an open-source [MOD DUO](https://www.moddevices.com/) emulator for Linux based on Docker that lets you play around with hundreds of LV2 audio plugins!
This project aims to provide a docker container in order to use mod-host and mod-ui painlessly from your linux machine.

MOD DUO team has done a remarkable job for the whole Linux audio open-source community, so if you like this emulator you should go get the real thing!

This project is heavily inspired in [MODEP](https://github.com/BlokasLabs/modep)

# REQUIREMENTS

You need to be have docker installed, running JACK and be part of audio group.

# USAGE

- Clone the repo `git clone git@github.com:ajboni/mod-docker.git`
- `chmod +x run.sh`
- `./run.sh`
- go to `http://localhost:8888` and start playing!

# TODO / GOTCHAS

I am currently using kxrepos plugins as it was quick and easy way to got them, but it will be more beneficial to build the lv2 plugins directly from mod and [mod-lv2-data](<[https://link](https://github.com/moddevices/mod-lv2-data)>)

Also some plugins does not provide modguis so thy will be 'ugly'. Also some might not even work.

On another topic, I couldn't make mod-ui talk to mod-host other than localhost, thats why the container is just one. It might be nice to have them separated in the future.

![Mod-Docker](/img/img.png)
![Mod-Docker](/img/img2.png)
