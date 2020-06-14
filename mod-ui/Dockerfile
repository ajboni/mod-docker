FROM ubuntu

# Install dependencies
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install --no-install-recommends python3-pip python3-dev python3-venv python3-setuptools git build-essential libasound2-dev libjack-jackd2-dev liblilv-dev libjpeg-dev zlib1g-dev wget curl \	
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /home/mod && chmod +x /home/mod/wait-for-it.sh

# Build mod-ui
RUN git clone git@github.com:ajboni/mod-ui.git /home/mod/mod-ui
RUN python3 -m venv /home/mod/mod-ui/modui-env && chown -R :audio /home/mod/mod-ui/modui-env && chmod 775 /home/mod/mod-ui/modui-env
RUN /bin/bash -c "source /home/mod/mod-ui/modui-env/bin/activate"
RUN pip3 install -r /home/mod/mod-ui/requirements.txt
RUN make -C /home/mod/mod-ui/utils 

RUN chown :audio -R /home/mod && chmod -R 775 /home/mod

# install gosu for a better su+exec command
ARG GOSU_VERSION=1.12
RUN dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 

ENV MOD_DEV_ENVIRONMENT=0 
ENV MOD_LIVE_ISO=1
ENV MOD_HOST_ADDR=mod-host

# ENTRYPOINT /home/mod/wait-for-it.sh mod-host:5555
# Generate user same as host . (It will need to connect to host jack with same username)
CMD /home/mod/wait-for-it.sh mod-host:5555 \
	&& groupadd -f $GROUP_ID \
	&& useradd -m -g $GROUP_ID -G audio -u $USER_ID $USER_NAME || true  \
	# && rsync /home/mod/* -rElu /home/${USER} \
	# && ls -lah ~/mod-ui \
	&& echo ${MOD_LIVE_ISO} \
	&& gosu ${USER_NAME} python3 /home/mod/mod-ui/server.py 

# # CMD ls -lha /home 