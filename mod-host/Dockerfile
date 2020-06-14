FROM ubuntu

# Install dependemcies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \ 
	build-essential jackd2 git liblilv-dev libreadline-dev lilv-utils libjack-jackd2-dev python python3.6 python3.6 rsync wget 

# Build mod-host
RUN git clone https://github.com/moddevices/mod-host.git /home/mod/mod-host
RUN make -C /home/mod/mod-host && make install -C  /home/mod/mod-host

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

# Run mod host
# Generate user same as host . (It will need to connect to host jack with same username)
CMD echo ${USER_NAME} && echo ${GROUP_NAME} \ 
	&& groupadd -f $GROUP_ID \
	&& useradd -m -g $GROUP_ID -G audio -u $USER_ID $USER_NAME || true  \
	&& rsync /home/mod/* -rElu /home/${USER_NAME} \ 
	&& chown -R ${USER_NAME}:${GROUP_ID} /home/${USER_NAME} \
	&& gosu ${USER_NAME} id \
	&& gosu ${USER_NAME} mod-host -n -p 5555 -f 5556

# MOD_DEV_ENVIRONMENT=0 MOD_LIVE_ISO=1 python3 ~/mod-ui/server.py && \

# CMD ls -lha /home 