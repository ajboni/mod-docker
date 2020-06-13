FROM ubuntu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -q -y \ 
	build-essential jackd2 git liblilv-dev libreadline-dev lilv-utils libjack-jackd2-dev python python3-pip python3
RUN git clone https://github.com/moddevices/mod-host.git
RUN cd mod-host &&  make && make install
CMD mod-host && jack_simple_client && sleep 10