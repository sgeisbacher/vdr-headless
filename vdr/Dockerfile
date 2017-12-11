FROM debian:stretch
MAINTAINER Stefan Geisbacher <stefan.geisbacher@gmail.com>

WORKDIR /tmp

#RUN mkdir -p /var/lib/video

ENV DEBIAN_FRONTEND noninteractive

#vdr-plugin-restfulapi
RUN apt-get update && \
	apt-get install -qy \
	vdr \
	vdr-plugin-epgsearch \
	vdr-plugin-live \
	vdr-plugin-svdrpservice \
	vdr-plugin-streamdev-server \
	vdr-plugin-vnsiserver \
	libmariadbclient18 uuid \
	nano && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /run.sh

# Configure the vdr user account and it's folders
RUN groupmod -o -g 666 vdr \
 && usermod -o -u 666 vdr \
 && install -o vdr -g vdr -d /recordings /var/cache/vdr /var/lib/vdr

RUN chmod a+x /usr/bin/vdr && chmod a+x /run.sh

ADD streamdevhosts.conf /etc/vdr/plugins/streamdev-server/streamdevhosts.conf
ADD vnsiserver_allowed_hosts.conf /etc/vdr/plugins/vnsiserver/allowed_hosts.conf
ADD setup.conf /etc/vdr/setup.conf
ADD channels.conf /etc/vdr/channels.conf

VOLUME /var/lib/video

EXPOSE 2004 3000 6419 8002 8008 4010-4020/udp 34890

ENTRYPOINT /run.sh
