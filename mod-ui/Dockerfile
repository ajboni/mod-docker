FROM mod-host

ENV REBUILD=true
ENV DEBIAN_FRONTEND=noninteractive


# Install dependencies
RUN apt-get update \
	&& apt-get -y install --no-install-recommends python3-pip python3-dev python3-venv python3-setuptools git build-essential libasound2-dev libjack-jackd2-dev liblilv-dev libjpeg-dev zlib1g-dev wget curl \	
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*


# Build mod-ui
RUN echo 2
RUN git clone https://github.com/ajboni/mod-ui.git /mod/mod-ui
RUN pip3 install -r /mod/mod-ui/requirements.txt
RUN make -C /mod/mod-ui/utils 
RUN chown :audio -R /mod/mod-ui && chmod -R 775 /mod/mod-ui
RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /mod/mod-ui && chmod +x /mod/mod-ui/wait-for-it.sh


# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

ENV MOD_DEV_ENVIRONMENT=0 
ENV USE_STANDARD_JACK_OUTPUTS = 1
ENV MOD_HOST_ADDR="localhost"
RUN chown :audio -R /mod/mod-ui && chmod -R 775 /mod/mod-ui

# ENTRYPOINT /mod/mod/wait-for-it.sh mod-host:5555
# RUN mkdir /mod/mod-ui && touch /mod/mod-ui/aa.txt && ls -la /mod/mod-ui 

# Generate user same as host . (It will need to connect to host jack with same username)
CMD groupadd -f $GROUP_ID \
	&& useradd -m -g $GROUP_ID -G audio -u $USER_ID $USER_NAME || true  \
	# && ls -lah ~/mod-ui \
	# && /mod/mod-ui/wait-for-it.sh mod-host:5555 \
	# && echo ${MOD_LIVE_ISO}docke \
	&& gosu ${USER_NAME} mod-host -p 5555 -f 5556 \
	&& gosu ${USER_NAME} python3 /mod/mod-ui/server.py 	

# # CMD ls -lha /home 