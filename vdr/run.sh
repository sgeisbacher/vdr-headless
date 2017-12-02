#!/bin/bash

# Set the uid:gid to run as
[ "$vdr_uid" ] && usermod  -o -u "$vdr_uid" vdr
[ "$vdr_gid" ] && groupmod -o -g "$vdr_gid" vdr

# Set folder permissions
# chown -r /recordings only if owned by root. We asume that means it's a docker volume
[ "$(stat -c %u:%g /recordings)" = "0:0" ] && chown vdr:vdr /recordings
[ "$(stat -c %u:%g /var/cache/vdr)" = "0:0" ] && chown vdr:vdr /var/cache/vdr
[ "$(stat -c %u:%g /var/lib/vdr)" = "0:0" ] && chown vdr:vdr /var/lib/vdr

vdr -v /recordings -c /etc/vdr -s -E /var/cache/vdr/epg.data -u root \
    --port 6419 --dirnames=,,1 -w 60 -P epgsearchonly -P streamdev-server -P vnsiserver -P epgsearch -P live
