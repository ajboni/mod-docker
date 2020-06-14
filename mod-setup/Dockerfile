FROM ubuntu
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	apt-transport-https \
	curl \
	software-properties-common \
	nano \
	wget \
	git \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

# Install LV2 Plugins
RUN mkdir /home/mod && git clone https://github.com/moddevices/mod-lv2-data.git /home/mod/mod-lv2-data

# Generate user same as host . (It will need to connect to host jack with same username)
CMD echo ${USER_NAME} && echo ${GROUP_NAME} \ 
	&& groupadd -f $GROUP_ID \
	&& useradd -m -g $GROUP_ID -G audio -u $USER_ID $USER_NAME || true  \
	&& cp -a /home/mod/mod-lv2-data/plugins-fixed/.  /home/$USER_NAME/.lv2
# ENTRYPOINT id &&  useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo