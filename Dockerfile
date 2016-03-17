FROM ubuntu:15.10
RUN mkdir /opt/ripple
WORKDIR /opt/ripple

RUN useradd rippled
RUN chown -R rippled:rippled /opt/ripple

RUN apt-get update
RUN apt-get -y install gcc git scons libprotobuf-dev libssl-dev libboost-all-dev nodejs pkg-config protobuf-compiler supervisor jq curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get -y install nodejs build-essential

RUN git clone https://github.com/ripple/rippled.git
RUN cd rippled && scons -j `nproc` --static
RUN mkdir -p /opt/ripple/bin
RUN cp rippled/build/rippled /opt/ripple/bin/rippled
RUN mkdir -p /opt/ripple/etc
RUN cp rippled/doc/rippled-example.cfg /opt/ripple/etc/rippled.cfg
RUN mkdir -p /var/log/rippled
RUN chown -R rippled:rippled /var/log/rippled
RUN chmod 755 /var/log/rippled/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY init_config_volume.sh ./
COPY init_data_volume.sh ./
COPY configure_validator.sh ./

RUN mkdir /root/tmp/
RUN mkdir -p /var/log/supervisor

RUN cd rippled && npm install

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
