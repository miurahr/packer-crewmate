#!/bin/sh

# Next environment variables should be set using
# docker -e "VAR=val" command line arguments
# --
#
# --

CONF=/etc/supervisor/conf.d/crewmate.conf

sudo sed -ri "s/CREWMATE_DB_SERVER=[^,]*/CREWMATE_DB_SERVER=${CREWMATE_DB_SERVER}/g" $CONF

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
