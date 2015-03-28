#!/bin/sh

# Next environment variables should be set using
# docker -e "VAR=val" command line arguments
# --
#
# --

DBCONF=/srv/crewmate/confing/database.yml

if [ "${CREWMATE_DB_NAME}" != "" ]; then
  sed -ri "s/database=[^,]*/database=${CREWMATE_DB_NAME}/g" $DBCONF
fi
if [ "${CREWMATE_DB_SERVER}" != "" ]; then
  sed -ri "s/host=[^,]*/host=${CREWMATE_DB_SERVER}/g" $DBCONF
fi
if [ "${CREWMATE_DB_USER}" != "" ]; then
  sed -ri "s/username=[^,]*/username=${CREWMATE_DB_USER}/g" $DBCONF
fi
if [ "${CREWMATE_DB_PASS}" != "" ]; then
  sed -ri "s/password=[^,]*/password=${CREWMATE_DB_PASS}/g" $DBCONF
fi

APPCONF=/srv/crewmate/confing/crewmate.yml

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
