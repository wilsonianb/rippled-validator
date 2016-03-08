FROM centos:latest
RUN mkdir /opt/ripple
WORKDIR /opt/ripple

# Use Fedora EPEL for jq
RUN yum install -y wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -ivh epel-release-7-5.noarch.rpm
RUN yum install -y jq

RUN yum install -y supervisor

RUN rpm -Uvh https://mirrors.ripple.com/ripple-repo-el7.rpm
RUN yum install -y --enablerepo=ripple-stable rippled-0.30.1_hf2

RUN mkdir -p /var/log/supervisor

EXPOSE 51235
EXPOSE 6006

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY init_config_volume.sh ./
COPY init_data_volume.sh ./
COPY configure_validator.sh ./

RUN mkdir /root/tmp/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
