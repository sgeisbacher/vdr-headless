FROM debian:stretch
MAINTAINER Stefan Geisbacher <stefan.geisbacher@gmail.com>

WORKDIR /tmp

#RUN mkdir -p /var/lib/video
#ADD channels.conf /etc/vdr/channels.conf

ENV DEBIAN_FRONTEND noninteractive

#vdr-plugin-restfulapi
RUN apt-get update && \
	apt-get install -qy \
	vdr \
	vdr-plugin-epgsearch \
	vdr-plugin-live \
	vdr-plugin-vnsiserver \
	vdr-plugin-svdrpservice \
	vdr-plugin-streamdev-server \
	libmariadbclient18 uuid \
	nano && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /run.sh

# add configs
#ADD var/lib/vdr/* /var/lib/vdr/
#ADD var/lib/vdr/plugins/streamdev-server/* /var/lib/vdr/plugins/streamdev-server/
#ADD var/lib/vdr/plugins/iptv/* /var/lib/vdr/plugins/iptv/
#RUN rm /etc/vdr/conf.d/*
#ADD etc/vdr/conf.d/* /etc/vdr/conf.d/

# Configure the vdr user account and it's folders
RUN groupmod -o -g 666 vdr \
 && usermod -o -u 666 vdr \
 && install -o vdr -g vdr -d /recordings /var/cache/vdr /var/lib/vdr

RUN chmod a+x /usr/bin/vdr && chmod a+x /run.sh

ADD streamdevhosts.conf /etc/vdr/plugins/streamdev-server/streamdevhosts.conf
ADD setup.conf /etc/vdr/setup.conf

VOLUME /var/lib/video

EXPOSE 2004 3000 6419 8002 8008 4010-4020/udp 34890

ENTRYPOINT /run.sh
